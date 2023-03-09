import 'package:flutter/material.dart';
import 'dart:math';

class CustomMyLimitPainter extends CustomPainter {
  double progressPercentage;
  double offSetAnimation;
  CustomMyLimitPainter({
    required this.progressPercentage,
    required this.offSetAnimation,
  }) : super() {
    if (progressPercentage > 100) {
      progressPercentage = 100;
    } else if (progressPercentage < 0) {
      progressPercentage = 0;
    }
  }
  @override
  void paint(Canvas canvas, Size size) {
    _paintArch(canvas, size);
    _paintProgress(size, canvas);
    _paintDottedArch(canvas, size);
    _paintCircleInsideArch(canvas, size);
  }

  double get _totalDistanceCovered => 360 - 60;
  double get _startPosition => 90 + (60 / 2);
  void _paintArch(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red.withOpacity(0.1)
      ..strokeWidth = 35
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawArc(Offset.zero & size, radian(_startPosition),
        radian(_totalDistanceCovered), false, paint);
  }

  void _paintProgress(Size size, Canvas canvas) {
    Color startColor = Colors.red;
    Color endColor = Colors.red.withOpacity(0.2);
    final gradient = LinearGradient(
      colors: [
        startColor,
        endColor,
      ],
    );
    final center = Offset(size.width, size.height);
    Paint paint = Paint()
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..shader = gradient.createShader(Rect.fromCircle(
        center: center,
        radius: size.width,
      ));
    canvas.drawArc(Offset.zero & size, radian(_startPosition),
        radian(_getProgressPosition), false, paint);
  }

  double get _getProgressPosition =>
      (progressPercentage / 100) * _totalDistanceCovered;

  void _paintDottedArch(Canvas canvas, Size size) {
    final radius = size.width / 3;
    final center = Offset(size.width / 2, size.height / 2);
    Rect rect = Rect.fromCircle(center: center, radius: radius);
    Paint paint = Paint()
      ..color = Colors.red.withOpacity(0.5)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    double width = 1;
    for (double i = 130 - offSetAnimation * 8;
        i <= 410 + offSetAnimation * 8;
        i += (width * 6)) {
      canvas.drawArc(rect, radian(i), radian(width), false, paint);
    }
  }

  void _paintCircleInsideArch(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = whiteDotWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = Colors.white;
    canvas.drawArc(Offset.zero & size, radian(getWhiteDotPosition),
        radian(minimumWidthPossible), false, paint);
  }

  double get whiteDotWidth => 12;

  double get getWhiteDotPosition => _getProgressPosition + _startPosition;

  double get minimumWidthPossible {
    if (_getProgressPosition < whiteDotWidth) {
      return 0;
    }
    return 0.01;
  }

  @override
  bool shouldRepaint(CustomMyLimitPainter oldDelegate) {
    return oldDelegate.progressPercentage != progressPercentage ||
        oldDelegate.offSetAnimation != offSetAnimation;
  }

  double radian(double degree) => degree * pi / 180;
}
