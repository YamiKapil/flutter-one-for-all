import 'dart:math';

import 'package:flutter/material.dart';

class MandalaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height / 2);
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    var radius = size.width * 0.05;
    var paint = Paint()
      ..strokeWidth = 2
      ..color = Colors.white
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke;
    const int numberOfDots = 10;
    const double radiantStep = 2 * pi / numberOfDots;
    for (int i = 0; i < numberOfDots; i++) {
      canvas.drawCircle(
        Offset(
          centerX + sin(i * radiantStep) * radius,
          centerY + cos(i * radiantStep) * radius,
        ),
        radius,
        paint,
      );
    }

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != oldDelegate;
  }
}
