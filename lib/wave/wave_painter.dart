import 'dart:math';

import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final double animationValue;
  final double radius;

  WavePainter(this.animationValue, this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint wavePaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    double waveHeight = 10.0;

    final Path path = Path();

    for (double i = 0; i <= 360; i += 10) {
      final double angle = i * (pi / 180.0);
      final double x =
          radius + (radius + waveHeight * sin(animationValue * 2 * pi)) * cos(angle);
      final double y =
          radius + (radius + waveHeight * sin(animationValue * 2 * pi)) * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();

    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}