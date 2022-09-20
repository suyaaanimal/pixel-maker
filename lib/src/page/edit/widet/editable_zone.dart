import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pixel_maker/src/conponent/interactive_viewer_clone.dart'
    show MyInteractiveViewer;
import 'package:pixel_maker/src/controller/edit_screen/edit_screen_controller.dart';
import 'package:pixel_maker/src/controller/edit_screen/edit_screen_state.dart';
import 'package:pixel_maker/src/controller/image/image_controller.dart';
import 'package:pixel_maker/src/controller/image/image_state.dart';
import 'package:pixel_maker/src/enums/edit_screen_enum.dart';
import 'package:pixel_maker/src/model/pixel_model.dart';
import 'package:provider/provider.dart';

class EditableZone extends StatefulWidget {
  const EditableZone({super.key});

  @override
  State<EditableZone> createState() => _EditableZoneState();
}

class _EditableZoneState extends State<EditableZone>
    with SingleTickerProviderStateMixin {
  static const scaleMax = 4.0;
  static const scaleMin = 1.0;

  final transformationController = TransformationController();

  @override
  void dispose() {
    transformationController.dispose();
    super.dispose();
  }

  void actionOnPixel(PixelModel e) {
    final screenState = context.read<EditScreenState>();
    final screenController = context.read<EditScreenController>();
    final imageController = context.read<ImageController>();
    switch (screenState.page) {
      case EditScreenEnum.pen:
        imageController.updateColor(e, screenState.penColor);
        break;
      case EditScreenEnum.eraser:
        imageController.updateColor(e, screenState.eraseredColor);
        break;
      case EditScreenEnum.spoit:
        screenController.updatePenColor(e.color);
        break;
      case EditScreenEnum.colorPicker:
        throw Exception('pixel tapped on color picker mode');
      case EditScreenEnum.preview:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenState = context.watch<EditScreenState>();
    final imageState = context.watch<ImageState>();
    final imageController = context.read<ImageController>();
    return LayoutBuilder(
      builder: (context, constraint) {
        final pixelBorderWidth =
            screenState.page == EditScreenEnum.preview ? 0.0 : 1.0;
        final pixelOneSideSize = imageState.size;
        final wholeOneSideLength =
            math.min(constraint.maxHeight, constraint.maxWidth) -
                pixelBorderWidth * 2;
        final pixelOneSideLength = wholeOneSideLength / pixelOneSideSize;
        return Center(
          child: Column(
            children: [
              MyInteractiveViewer(
                maxScale: scaleMax,
                minScale: scaleMin,
                transformationController: transformationController,
                onPan: (details) {
                  final offset = details.localFocalPoint;
                  if (!(0 < offset.dx && offset.dx < wholeOneSideLength) ||
                      !(0 < offset.dy && offset.dy < wholeOneSideLength)) {
                    return;
                  }
                  final trans = transformationController.value.getTranslation();
                  final scale =
                      transformationController.value.getMaxScaleOnAxis();
                  final row =
                      (offset.dx - trans.x) / scale ~/ pixelOneSideLength;
                  final column =
                      (offset.dy - trans.y) / scale ~/ pixelOneSideLength;
                  if (!(0 <= row && row < 16) ||
                      !(0 <= column && column < 16)) {
                    return;
                  }

                  actionOnPixel(imageState.pixels[column][row]);
                },
                onPanEnd: (details) {
                  imageController.setHistory();
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: screenState.page == EditScreenEnum.preview
                          ? null
                          : Border.all(
                              color: Colors.grey, width: pixelBorderWidth)),
                  child: Column(
                      children: imageState.pixels
                          .map(
                            (rowPixels) => Row(
                              children: rowPixels
                                  .map((e) => GestureDetector(
                                        onTap: () {
                                          actionOnPixel(e);
                                          imageController.setHistory();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.zero,
                                          width: pixelOneSideLength,
                                          height: pixelOneSideLength,
                                          decoration: BoxDecoration(
                                              border: screenState.page ==
                                                      EditScreenEnum.preview
                                                  ? null
                                                  : Border.all(
                                                      width: pixelBorderWidth,
                                                      color: Colors.grey,
                                                      strokeAlign:
                                                          StrokeAlign.outside,
                                                    ),
                                              color: e.color),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          )
                          .toList()),
                ),
              ),
              AnimatedBuilder(
                  animation: transformationController,
                  builder: (context, child) {
                    return Slider(
                        min: scaleMin,
                        max: scaleMax,
                        value:
                            transformationController.value.getMaxScaleOnAxis(),
                        onChanged: (value) {
                          final deltaScale = value /
                              transformationController.value
                                  .getMaxScaleOnAxis();
                          // TODO:(atahatah) これを外すとバグる
                          if (deltaScale > 2) return;
                          transformationController.value.scale(deltaScale);

                          final deltaTrns = (deltaScale - 1.0) / 2.0;
                          double transX = -deltaTrns * wholeOneSideLength;
                          double transY = -deltaTrns * wholeOneSideLength;
                          transformationController.value
                              .translate(transX, transY);

                          final currentTrns =
                              transformationController.value.getTranslation();
                          final currentScale = transformationController.value
                              .getMaxScaleOnAxis();

                          double fixTransX = 0.0;
                          double fixTransY = 0.0;
                          if (currentTrns.x > 0) {
                            fixTransX = currentTrns.x;
                          } else if (-(currentTrns.x - wholeOneSideLength) >
                              wholeOneSideLength * currentScale) {
                            fixTransX = currentTrns.x -
                                wholeOneSideLength +
                                wholeOneSideLength * currentScale;
                          }
                          if (currentTrns.y > 0) {
                            fixTransY = currentTrns.y;
                          } else if (-(currentTrns.y - wholeOneSideLength) >
                              wholeOneSideLength * currentScale) {
                            fixTransY = currentTrns.y -
                                wholeOneSideLength +
                                wholeOneSideLength * currentScale;
                          }
                          transformationController.value
                              .translate(-fixTransX, -fixTransY);
                          setState(() {});
                        });
                  }),
              Row(
                children: [
                  Visibility(
                    visible: imageState.history.backable,
                    replacement: Opacity(
                      opacity: 0.2,
                      child: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.arrow_back)),
                    ),
                    child: IconButton(
                        onPressed: () => imageController.back(),
                        icon: const Icon(Icons.arrow_back)),
                  ),
                  Visibility(
                    visible: imageState.history.nextable,
                    replacement: Opacity(
                      opacity: 0.2,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward)),
                    ),
                    child: IconButton(
                        onPressed: () => imageController.forward(),
                        icon: const Icon(Icons.arrow_forward)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
