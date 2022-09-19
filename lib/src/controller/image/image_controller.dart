import 'package:flutter/material.dart';
import 'package:pixel_maker/src/controller/image/image_state.dart';
import 'package:pixel_maker/src/model/pixel_model.dart';
import 'package:state_notifier/state_notifier.dart';

class ImageController extends StateNotifier<ImageState> {
  ImageController({size = 16}) : super(ImageState.fromLength(size));

  updateColor(PixelModel old, Color newColor) {
    state = state.copyWith(pixels: [
      for (final row in state.pixels)
        [for (final e in row) e != old ? e : PixelModel(color: newColor)]
    ]);
  }
}
