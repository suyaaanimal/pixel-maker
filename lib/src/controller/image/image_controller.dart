import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pixel_maker/src/model/coordinate.dart';
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

  fillColor(PixelModel old, Color newColor) {
    final newPixels = List<List<PixelModel>>.generate(
        state.size, (index) => List.of(state.pixels[index]));
    final exploredPixels = List<List<bool>>.generate(
        state.size, (index) => List<bool>.filled(state.size, false));

    late final Coordinate startPosition;
    for (int i = 0; i < state.size; i++) {
      for (int j = 0; j < state.size; j++) {
        if (state.pixels[i][j] == old) {
          startPosition = Coordinate(i, j);
        }
      }
    }

    // 幅優先探索
    final q = Queue<Coordinate>.of([startPosition]);
    while (q.isNotEmpty) {
      final current = q.removeLast();
      newPixels[current.x][current.y] = PixelModel(color: newColor);
      for (final p in [
        Coordinate(-1, 0),
        Coordinate(1, 0),
        Coordinate(0, 1),
        Coordinate(0, -1),
      ]) {
        final v = current + p;
        if (!v.insideOf(0, 0, state.size - 1, state.size - 1)) continue;
        if (!exploredPixels[v.x][v.y] &&
            state.pixels[v.x][v.y].color == old.color) {
          q.add(v);
          exploredPixels[v.x][v.y] = true;
        }
      }
    }
    state = state.copyWith(pixels: newPixels);
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
