import 'package:flutter/material.dart';
import 'package:pixel_maker/src/model/pixel_model.dart';

@immutable
class ImageHistory {
  const ImageHistory({required this.list, required this.index});
  final List<List<List<PixelModel>>> list;
  final int index;

  ImageHistory push(List<List<PixelModel>> image) {
    return ImageHistory(
      list: [
        for (int i = 0; i <= index; i++) list[i],
        image,
      ],
      index: index + 1,
    );
  }

  bool get nextable => index < list.length - 1;

  ImageHistory forward() => ImageHistory(list: list, index: index + 1);
  List<List<PixelModel>> get next => list[index + 1];

  bool get backable => index > 0;

  ImageHistory back() => ImageHistory(list: list, index: index - 1);
  List<List<PixelModel>> get prev => list[index - 1];

  ImageHistory clear(List<List<PixelModel>> firstImage) =>
      ImageHistory(list: [firstImage], index: 0);
}
