import 'dart:math';

import 'package:flutter/material.dart';

@immutable
class PixelModel {
  PixelModel({required this.color}) : _hashCode = r().hashCode;

  final Color color;
  final int _hashCode;

  static final r = Random().nextDouble;

  @override
  int get hashCode => _hashCode;

  @override
  bool operator ==(Object other) {
    return other is PixelModel && other.hashCode == hashCode;
  }
}
