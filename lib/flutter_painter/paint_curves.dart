import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

import 'package:one_for_all/flutter_painter/limit_painter.dart';

class PaintCurves extends StatefulWidget {
  const PaintCurves({super.key});

  @override
  State<PaintCurves> createState() => _PaintCurvesState();
}

class _PaintCurvesState extends State<PaintCurves> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paint Curves'),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.width / 2,
          width: MediaQuery.of(context).size.width / 2,
          child: CustomPaint(
            // painter: SplinePainter(),
            painter: CurvePainter(),
            // painter: CustomMyLimitPainter(
            //   offSetAnimation: 10,
            //   progressPercentage: 200,
            // ),
          ),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final successPath = Path();
    final curvePath = Path();
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawPaint(Paint()..color = Colors.red);
    // creating line for success tick

    successPath.moveTo(
      center.dx + radius / 3 * cos(3),
      center.dy + radius / 3 * sin(3.3),
    );
    successPath.lineTo(
      center.dx + radius / 3 * cos(2.2),
      center.dy + radius / 3 * sin(2.2),
    );
    successPath.lineTo(
      center.dx + radius / 2 * cos(0),
      center.dy + radius / 3 * sin(-0.5),
    );
    // curve path..
    curvePath.moveTo(
      center.dx + radius * cos(135),
      center.dy + radius * sin(135),
    );
    // curvePath.quadraticBezierTo(
    //   center.dx,
    //   center.dy - size.height / 3,
    //   center.dx + radius * cos(0),
    //   center.dy + radius * sin(0),
    // );
    curvePath.cubicTo(
      center.dx,
      center.dy - size.height / 3,
      center.dx,
      center.dy + size.height / 3,
      center.dx + radius * cos(0),
      center.dy + radius * sin(0),
    );
    curvePath.moveTo(
      center.dx + radius * cos(90),
      center.dy + radius * sin(90),
    );
    curvePath.cubicTo(
      center.dx,
      center.dy + size.height / 10,
      center.dx,
      center.dy + size.height / 10,
      center.dx + radius * cos(45),
      center.dy + radius * sin(45),
    );

    // curvePath.moveTo(
    //   center.dx + radius * cos(135),
    //   center.dy + radius * sin(135),
    // );
    // curvePath.quadraticBezierTo(
    //   center.dx,
    //   center.dy - size.height / 1,
    //   center.dx + radius * cos(0),
    //   center.dy + radius * sin(0),
    // );
    // curvePath.moveTo(
    //   center.dx + radius * cos(135),
    //   center.dy + radius * sin(135),
    // );
    // curvePath.quadraticBezierTo(
    //   center.dx,
    //   center.dy + size.height / 1,
    //   center.dx + radius * cos(0),
    //   center.dy + radius * sin(0),
    // );
    // curvePath.moveTo(
    //   center.dx + radius * cos(135),
    //   center.dy + radius * sin(135),
    // );
    // curvePath.quadraticBezierTo(
    //   center.dx,
    //   center.dy + size.height / 3,
    //   center.dx + radius * cos(0),
    //   center.dy + radius * sin(0),
    // );
    // curvePath.quadraticBezierTo(
    //   center.dx + radius * cos(180),
    //   center.dy + radius * sin(180),
    //   center.dx + radius * cos(0),
    //   center.dy + radius * sin(0),
    // );

    // color for circle stroke
    final paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 5;
    // color for success or failure path
    final successPaint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 10;
    // fill the inside of the circle
    final fillPaint = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.round;

    canvas.drawArc(rect, -pi, -pi * 2, false, fillPaint);

    // canvas.drawPath(successPath, successPaint);
    canvas.drawPath(curvePath, paint);

    // if (loadingCompleted == false) {
    //   canvas.drawArc(rect, -pi, -pi * 1.5, false, paint);
    // }
    // canvas.drawArc(rect, -pi, -pi * 2 * animationProgress!, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
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
      ..shader = LinearGradient(
        colors: [
          Colors.purple[400]!,
          Colors.teal[400]!,
        ],
      ).createShader(
        Offset(0, size.height * 0.8) & size,
      );
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

num pieceWiseFunction(int x) {
  if (x < 2) {
    return pow(x, 2);
  } else if (x == 2) {
    return 6;
  } else if (x > 2 && x <= 6) {
    return 10 - x;
  }
  return 0;
}

class SplinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()..color = Colors.white);
    const controlWidthSingle = 50;
    final random = Random();

    /// This method generates control points, the x = 50*index(+1)
    /// the y is set to random values between half of the screen and bottom of the screen
    final controlPoints = List.generate(
      size.width ~/ controlWidthSingle,
      (index) => Offset(
        controlWidthSingle * (index + 1),
        random.nextDouble() * (size.height - size.height / 2) + size.height / 2,
      ),
    ).toList();
    final spline = CatmullRomSpline(controlPoints);
    final bezierPaint = Paint() // set the edges of stroke to be rounded
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12 // apply a gradient
      ..shader = const LinearGradient(colors: [
        Colors.purple,
        Colors.teal,
      ]).createShader(Offset(0, size.height) &
          size); // This method accepts a list of offsets and draws points for all offset
    canvas.drawPoints(
      PointMode.points,
      spline.generateSamples().map((e) => e.value).toList(),
      bezierPaint,
    );
  }

  @override
  bool shouldRepaint(SplinePainter oldDelegate) => false;
}
