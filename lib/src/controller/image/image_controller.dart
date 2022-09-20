import 'package:flutter/material.dart';
import 'package:pixel_maker/src/controller/image/image_state.dart';
import 'package:pixel_maker/src/model/pixel_model.dart';
import 'package:state_notifier/state_notifier.dart';

class ImageController extends StateNotifier<ImageState> {
  ImageController({size = 16, String? docId})
      : super(ImageState.fromLength(
          size,
          docId: docId ?? '',
        ));

  ImageController.update(
    int size,
    List<List<Color>> pixels,
    String docId,
  ) : super(ImageState.update(
            size: size,
            pixels: [
              for (final row in pixels)
                [for (final e in row) PixelModel(color: e)],
            ],
            docId: docId));

  updateColor(PixelModel old, Color newColor) {
    state = state.copyWith(pixels: [
      for (final row in state.pixels)
        [for (final e in row) e != old ? e : PixelModel(color: newColor)]
    ]);
  }

  updateColorAndSetHistory(PixelModel old, Color newColor) {
    state = state.copyWith(
      pixels: [
        for (final row in state.pixels)
          [for (final e in row) e != old ? e : PixelModel(color: newColor)]
      ],
      history: state.history.push(state.pixels),
    );
  }

  setHistory() {
    state = state.copyWith(history: state.history.push(state.pixels));
  }

  forward() => state = state.copyWith(
      pixels: state.history.next, history: state.history.forward());

  back() => state =
      state.copyWith(pixels: state.history.prev, history: state.history.back());
}
