import 'package:flutter/material.dart';
import 'dart:math' as math;

class StepProgressIndicator extends StatefulWidget {
  final double size;
  final int currentPage;
  final int totalPage;
  const StepProgressIndicator(
      {super.key,
      required this.size,
      required this.currentPage,
      required this.totalPage});
  @override
  State<StepProgressIndicator> createState() => _StepProgressIndicatorState();
}

class _StepProgressIndicatorState extends State<StepProgressIndicator>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: CustomPaint(
        painter: StepProgressIndicatorPainter(
          progress: widget.currentPage / widget.totalPage,
          radius: widget.size / 2,
        ),
      ),
    );
  }
}

class StepProgressIndicatorPainter extends CustomPainter {
  final double progress;
  final double radius;
  StepProgressIndicatorPainter({
    super.repaint,
    required this.progress,
    required this.radius,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Rect progressRect = Rect.fromCircle(center: center, radius: radius);
    final Paint progressPainter = Paint()
      ..color = Colors.red
      // ..strokeWidth = 4.sp
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final Paint backgroundPainter = Paint()
      ..color = Colors.yellow
      // ..strokeWidth = 4.sp
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    const double startAngle = math.pi / 2;
    const double backgroundStartAngle = (math.pi / 2) + 0.5;
    final double sweepAngle = 2 * math.pi * progress;
    final double sweepBackgroundAngle = ((2 * (math.pi)) - sweepAngle) - 1;
    canvas.drawArc(
      progressRect,
      backgroundStartAngle,
      sweepBackgroundAngle,
      false,
      backgroundPainter,
    );
    canvas.drawArc(
      progressRect,
      startAngle,
      -sweepAngle,
      false,
      progressPainter,
    );
  }

  @override
  bool shouldRepaint(StepProgressIndicatorPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
