import 'package:flutter/material.dart';
import 'package:pixel_maker/src/model/pixel_model.dart';

@immutable
class ImageState {
  const ImageState({required this.pixels}) : size = pixels.length;
  ImageState.fromLength(this.size)
      : pixels = List.generate(
            size,
            (_) => List.generate(
                size, (_) => PixelModel(color: const Color(0xFFFFFFFF))));

  final int size;
  final List<List<PixelModel>> pixels;

  ImageState copyWith({
    List<List<PixelModel>>? pixels,
  }) =>
      ImageState(
        pixels: pixels ?? this.pixels,
      );
}
