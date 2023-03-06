import 'package:flutter/material.dart';
import 'dart:math';

class LoadingSuccessAnimation extends StatefulWidget {
  const LoadingSuccessAnimation({super.key});

  @override
  State<LoadingSuccessAnimation> createState() =>
      _LoadingSuccessAnimationState();
}

class _LoadingSuccessAnimationState extends State<LoadingSuccessAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading Success Animation'),
      ),
      body: Center(
        child: CustomPaint(
          painter: LoadingPainter(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
      ),
    );
  }
}

class LoadingPainter extends CustomPainter {
  AnimationController? loadingAnimation;
  AnimationController? successAnimation;
  LoadingPainter({
    this.loadingAnimation,
    this.successAnimation,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final successPath = Path();
    final rect = Rect.fromCircle(center: center, radius: radius);

    successPath.moveTo(
      center.dx + (radius - 20) * cos(3),
      center.dy + (radius - 20) * sin(3),
    );
    successPath.lineTo(
      center.dx + (radius - 20) * cos(2),
      center.dy + (radius - 20) * sin(2),
    );
    successPath.lineTo(
      center.dx + (radius - 20) * cos(0),
      center.dy + (radius - 20) * sin(0),
    );

    final paint = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 10;

    canvas.drawArc(rect, -pi, -pi * 2, false, paint);

    canvas.drawPath(successPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
