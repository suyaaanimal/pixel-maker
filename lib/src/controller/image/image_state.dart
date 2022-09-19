import 'package:flutter/material.dart';

@immutable
class ImageState {
  ImageState(this.size);

  final int size;
  late final pixels =
      List.filled(size, List.filled(size, const Color(0xFFFFFFFF)));
}
