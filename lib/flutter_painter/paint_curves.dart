import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

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
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          child: CustomPaint(
            painter: SplinePainter(),
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
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = Path();
    path.quadraticBezierTo(200, 200, 300, 300);
    canvas.drawPath(path, paint);
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
