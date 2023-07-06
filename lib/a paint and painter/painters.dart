import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;

extension on num {
  double get radian => (this * math.pi) / 180;
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // drawing line
    var paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5;

    var point1 = Offset(0, size.height / 2);
    var point2 = Offset(size.width, size.height / 2);
    canvas.drawLine(point1, point2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.green;
    var center = Offset(size.width / 2, size.height / 2);
    var radius = size.width / 2;
    var rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate != oldDelegate);
  }
}

class RectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.green;
    var center = Offset(size.width / 2, size.height / 2);
    var rect = Rect.fromCenter(center: center, width: 200, height: 400);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate != oldDelegate);
  }
}

class OvalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // var paint = Paint()..color = Colors.green;
    var paint2 = Paint()..color = Colors.red;
    var center = Offset(size.width / 2, size.height / 2);
    var rect = Rect.fromCenter(center: center, width: 200, height: 200);
    // canvas.drawRect(rect, paint);
    canvas.drawOval(rect, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate != oldDelegate);
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.green;
    var center = Offset(size.width / 2, size.height / 2);
    var rect = Rect.fromCenter(center: center, width: 200, height: 200);
    canvas.drawArc(rect, 0, 90.radian, true, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate != oldDelegate);
  }
}

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    var path = Path();
    // path.moveTo(0, 0);
    // path.lineTo(size.width, size.height);

    /// Quadratic Bezier curve
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height / 2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate != oldDelegate);
  }
}

class QuadraticBezierCurvePainter extends CustomPainter {
  const QuadraticBezierCurvePainter();
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()..color = Colors.white);
    Path bezierPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.8)
      ..quadraticBezierTo(
        size.width / 2,
        size.height * 0.6,
        size.width,
        size.height * 0.8,
      )
      ..lineTo(size.width, size.height);
    final bezierPaint = Paint()
      ..shader = LinearGradient(colors: [Colors.red, Colors.teal[400]!])
          .createShader(Offset(0, size.height * 0.8) & size);
    canvas.drawPath(bezierPath, bezierPaint);
  }

  @override
  bool shouldRepaint(QuadraticBezierCurvePainter oldDelegate) => false;
}

class CubicBezierCurvePainter extends CustomPainter {
  const CubicBezierCurvePainter();
  @override
  void paint(Canvas canvas, Size size) {
    /// Paints the whole canvas white
    canvas.drawPaint(Paint()..color = Colors.white);

    /// Translate method shifts the coordinate of the canvas, in this case we are shifting
    /// the point of origin to the top-center of  the canvas
    canvas.translate(size.width / 2, 0);
    final width = size.width / 2;
    Path bezierPath = Path()
      ..moveTo(-width, size.height)
      ..lineTo(-width, size.height * 0.6)
      ..cubicTo(
        -width * 0.2,
        size.height * 0.4,
        0,
        size.height * 0.8,
        width,
        size.height * 0.6,
      )
      ..lineTo(width, size.height);
    final bezierPaint = Paint()
      ..shader = LinearGradient(colors: [
        Colors.purple[400]!,
        Colors.teal[400]!,
      ]).createShader(Offset(-width, size.height) & size);
    canvas.drawPath(bezierPath, bezierPaint);
  }

  @override
  bool shouldRepaint(CubicBezierCurvePainter oldDelegate) => false;
}

class LinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    var unitAngle = 360 / 12;
    for (int i = 0; i <= 11; i++) {
      final angle = -90.radian + (i * unitAngle).radian;
      canvas.drawLine(
        Offset.fromDirection(angle, 70),
        Offset.fromDirection(angle, 80),
        Paint()
          ..color = Colors.red
          ..strokeWidth = 4,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DashedProgressIndicator extends CustomPainter {
  final double percent;
  final double strokeWidth;

  DashedProgressIndicator({this.percent = 0, this.strokeWidth = 5});

  final paint1 = Paint()
    ..color = Colors.grey[300]!
    ..style = PaintingStyle.stroke;

  final paint2 = Paint()
    ..color = Colors.grey
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    final dashSize = (size.width * 0.0004) / 2;
    double arcAngle = 2 * pi * dashSize;

    // draw dashes
    for (var i = 0; i < 24; i++) {
      final init = (-pi / 2) * (i / 6);

      canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
          init,
          arcAngle,
          false,
          paint1..strokeWidth = strokeWidth);
    }

    // draw progress
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        (-pi / 2),
        2 * pi * percent,
        false,
        paint2..strokeWidth = strokeWidth);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
