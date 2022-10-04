import 'package:flutter/material.dart';

class Transparent extends StatelessWidget {
  const Transparent({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: TransParentPainter());
  }
}

class TransParentPainter extends CustomPainter {
  final split = 4;
  final color = Colors.grey;
  final backgroundColor = Colors.white;
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width / split;
    final height = size.height / split;
    final paint = Paint()..color = color;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        paint..color = backgroundColor);

    paint.color = color;
    for (int i = 0; i < split; i++) {
      for (int j = 0; j < split; j++) {
        if ((i + j) % 2 == 1) continue;
        canvas.drawRect(
            Rect.fromLTWH(i * width, j * width, width, height), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
