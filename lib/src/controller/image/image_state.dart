import 'package:flutter/material.dart';
import 'package:pixel_maker/src/model/image_history.dart';
import 'package:pixel_maker/src/model/pixel_model.dart';

@immutable
class ImageState {
  // ignore: prefer_const_constructors_in_immutables
  ImageState({
    required this.pixels,
    required this.history,
    required this.docId,
  }) : size = pixels.length;

  ImageState.fromLength(
    this.size, {
    required this.docId,
  }) : pixels = List.generate(
            size,
            (_) => List.generate(
                size, (_) => PixelModel(color: const Color(0xFFFFFFFF)))) {
    history = ImageHistory(list: [pixels], index: 0);
  }

  ImageState.update({
    required this.size,
    required this.pixels,
    required this.docId,
  }) : history = ImageHistory(list: [pixels], index: 0);

  final int size;
  final List<List<PixelModel>> pixels;
  late final ImageHistory history;
  final String docId;

  ImageState copyWith({
    List<List<PixelModel>>? pixels,
    ImageHistory? history,
    String? docId,
  }) =>
      ImageState(
        pixels: pixels ?? this.pixels,
        history: history ?? this.history,
        docId: docId ?? this.docId,
      );
}
