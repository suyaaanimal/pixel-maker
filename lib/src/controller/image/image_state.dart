import 'package:flutter/material.dart';
import 'package:pixel_maker/src/model/image_history.dart';
import 'package:pixel_maker/src/model/pixel_model.dart';

@immutable
class ImageState {
  ImageState({required this.pixels, required this.history})
      : size = pixels.length;

  ImageState.fromLength(this.size)
      : pixels = List.generate(
            size,
            (_) => List.generate(
                size, (_) => PixelModel(color: const Color(0xFFFFFFFF)))) {
    history = ImageHistory(list: [pixels], index: 0);
  }

  final int size;
  final List<List<PixelModel>> pixels;
  late final ImageHistory history;

  ImageState copyWith({
    List<List<PixelModel>>? pixels,
    ImageHistory? history,
  }) =>
      ImageState(
        pixels: pixels ?? this.pixels,
        history: history ?? this.history,
      );
}
