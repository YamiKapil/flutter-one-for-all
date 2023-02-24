import 'package:flutter/material.dart';
import 'dart:math' show pi;

class CustomPieChart extends StatelessWidget {
  const CustomPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pie Chart'),
      ),
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          child: CustomPaint(
            foregroundPainter: CircularProgress(
              animationProgress: 0.0,
              progress: 50,
              linearGradientFirstColor: Colors.blue,
              linearGradientSecondColor: Colors.green,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Text here'),
                Text('Text here'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CircularProgress extends CustomPainter {
  CircularProgress(
      {required this.animationProgress,
      required this.progress,
      this.linearGradientFirstColor,
      this.linearGradientSecondColor});
  final double strokeWidth = 20;
  final double animationProgress;
  final double progress;
  final Color? linearGradientFirstColor;
  final Color? linearGradientSecondColor;
  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = Paint()
      ..strokeWidth = strokeWidth
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    Offset center = Offset(size.width / 2, size.height / 2);
    double animatedRadius = size.width;

    canvas.drawCircle(center, animatedRadius, circle);

    Paint animationArch = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth + 20
      // ..shader = LinearGradient(
      //   begin: Alignment.topRight,
      //   end: Alignment.bottomRight,
      //   colors: [
      //     linearGradientFirstColor!,
      //     linearGradientSecondColor!,
      //   ],
      // ).createShader(Rect.fromCircle(center: center, radius: animatedRadius))
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    double angle = 2 * pi * (progress / 360);

    canvas.drawArc(Rect.fromCircle(center: center, radius: animatedRadius),
        -pi / 2, angle, false, animationArch);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
