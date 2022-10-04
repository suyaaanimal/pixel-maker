import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pixel_maker/src/conponent/dot_picture.dart';
import 'package:pixel_maker/src/controller/edit_screen/edit_screen_controller.dart';
import 'package:pixel_maker/src/controller/edit_screen/edit_screen_state.dart';
import 'package:pixel_maker/src/controller/image/image_state.dart';
import 'package:pixel_maker/src/enums/preview_pattern.dart';
import 'package:provider/provider.dart';

class PreviewZone extends StatefulWidget {
  const PreviewZone({super.key});

  @override
  State<PreviewZone> createState() => _PreviewZoneState();
}

class _PreviewZoneState extends State<PreviewZone> {
  @override
  Widget build(BuildContext context) {
    final imageState = context.watch<ImageState>();
    final screenState = context.watch<EditScreenState>();
    final screenController = context.read<EditScreenController>();
    return LayoutBuilder(builder: (context, constraints) {
      final maxSize = min(constraints.maxHeight, constraints.maxHeight);
      const controllerZoneHeight = 40.0;
      final operatableZoneHeight = constraints.maxHeight - controllerZoneHeight;
      return Column(
        children: [
          SizedBox(
            height: operatableZoneHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (screenState.previewPattern == PreviewPattern.image &&
                    screenState.file != null)
                  Image.file(screenState.file!),
                if (screenState.previewPattern == PreviewPattern.doted)
                  SizedBox(
                      width: maxSize,
                      height: maxSize,
                      child: const DotPicture(
                        size: 1,
                        pixels: [
                          [Colors.black]
                        ],
                        border: false,
                      )),
                SizedBox(
                  width: constraints.maxWidth,
                  height: operatableZoneHeight,
                  child: InteractiveViewer(
                    boundaryMargin: const EdgeInsets.all(double.infinity),
                    minScale: 0.1,
                    child: DotPicture(
                      size: imageState.size,
                      border: false,
                      pixels: [
                        for (int i = 0; i < imageState.size; i++)
                          [
                            for (int j = 0; j < imageState.size; j++)
                              imageState.pixels[i][j].color
                          ]
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: controllerZoneHeight,
            child: Row(children: [
              ...PreviewPattern.values
                  .map((e) => Row(children: [
                        Radio<PreviewPattern>(
                          value: e,
                          groupValue: screenState.previewPattern,
                          onChanged: screenController.changePreviewPattern,
                        ),
                        Text(e.title),
                      ]))
                  .toList(),
              const SizedBox(width: 8),
              if (screenState.previewPattern != PreviewPattern.none)
                ElevatedButton(
                    onPressed: () {
                      switch (screenState.previewPattern) {
                        case PreviewPattern.none:
                          break;
                        case PreviewPattern.image:
                          screenController.setPreviewImage();
                          break;
                        case PreviewPattern.doted:
                          screenController.setPreviewBackgroundDotted();
                          break;
                      }
                    },
                    child: const Text("変更")),
            ]),
          )
        ],
      );
    });
  }
}
