import 'dart:math';

import 'package:flutter/material.dart';

class DotPicture extends StatelessWidget {
  const DotPicture({
    required this.size,
    required this.pixels,
    required this.border,
    super.key,
  });
  final int size;
  final List<List<Color>> pixels;
  final bool border;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DotPicturePainter(
        size: size,
        pixels: pixels,
        border: border,
      ),
    );
  }
}

class DotPicturePainter extends CustomPainter {
  const DotPicturePainter({
    required this.size,
    required this.pixels,
    required this.border,
  });
  final int size;
  final List<List<Color>> pixels;
  final bool border;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final maxLength = min(size.width, size.height);
    final pixelLength = maxLength / this.size;
    for (int i = 0; i < this.size; i++) {
      for (int j = 0; j < this.size; j++) {
        canvas.drawRect(
          Rect.fromLTWH(
              pixelLength * i, pixelLength * j, pixelLength, pixelLength),
          paint..color = pixels[j][i],
        );
      }
    }

    if (!border) return;
    //TODO(atahatah):境界線を描く
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
