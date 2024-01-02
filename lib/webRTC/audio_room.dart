import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spinner_try/webRTC/web_rtc.dart';


final WebRtcController controller = WebRtcController(
  audio: true,
  video: false,
);

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

    Color fadedBlue;

    if (radius <= radius / 2) {
      // Blue color turns to black when radius is half or less
      fadedBlue = Colors.black;
    } else {
      // Fade out the blue color based on animation value
      fadedBlue = Colors.blue.withOpacity(1.0 - animationValue);
    }

    final Paint circlePaint = Paint()
      ..color = fadedBlue
      ..style = PaintingStyle.fill;

    double waveHeight = 10.0;

    final Path path = Path();

    for (double i = 0; i <= 360; i += 10) {
      final double angle = i * (pi / 180.0);
      final double x = radius +
          (radius + waveHeight * sin(animationValue * 2 * pi)) * cos(angle);
      final double y = radius +
          (radius + waveHeight * sin(animationValue * 2 * pi)) * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();

    canvas.drawPath(path, wavePaint);
    canvas.drawCircle(Offset(radius, radius), radius, circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
