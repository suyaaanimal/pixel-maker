import 'dart:math';

import 'package:flutter/material.dart';
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

class _EditableZoneState extends State<EditableZone> {
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
    return LayoutBuilder(
      builder: (context, constraint) {
        final pixelBorderWidth =
            screenState.page == EditScreenEnum.preview ? 0.0 : 1.0;
        final pixelOneSideSize = imageState.size;
        final wholeOneSideLength =
            min(constraint.maxHeight, constraint.maxWidth) -
                pixelBorderWidth * 2;
        final pixelOneSideLength = wholeOneSideLength / pixelOneSideSize;
        return Center(
          child: InteractiveViewer(
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
                                    onTap: () => actionOnPixel(e),
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
        );
      },
    );
  }
}
