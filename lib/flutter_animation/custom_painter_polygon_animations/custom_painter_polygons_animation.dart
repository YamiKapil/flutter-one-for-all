import 'package:flutter/material.dart';
import 'dart:math';

class CustomPainterPolygonsAnimation extends StatefulWidget {
  const CustomPainterPolygonsAnimation({super.key});

  @override
  State<CustomPainterPolygonsAnimation> createState() =>
      _CustomPainterPolygonsAnimationState();
}

class _CustomPainterPolygonsAnimationState
    extends State<CustomPainterPolygonsAnimation>
    with TickerProviderStateMixin {
  late AnimationController _sidesController;
  late Animation<int> _sidesAnimation;
  late AnimationController _radiusController;
  late Animation _radiusAnimation;
  late AnimationController _rotationController;
  late Animation _rotationAnimation;

  @override
  void dispose() {
    _sidesController.dispose();
    _radiusController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _sidesController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _sidesAnimation = IntTween(begin: 3, end: 10).animate(_sidesController);
    _radiusController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _radiusAnimation = Tween(begin: 20.0, end: 400.0)
        .chain(CurveTween(curve: Curves.bounceInOut))
        .animate(_radiusController);
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _rotationAnimation = Tween(
      begin: 0.0,
      end: 2 * pi,
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(_rotationController);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sidesController.repeat(reverse: true);
    _radiusController.repeat(reverse: true);
    _rotationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Custome Painter Polygons Animation',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: AnimatedBuilder(
              animation: Listenable.merge(
                [
                  _radiusController,
                  _sidesController,
                  _rotationController,
                ],
              ),
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateX(_rotationAnimation.value)
                    ..rotateY(_rotationAnimation.value)
                    ..rotateZ(_rotationAnimation.value),
                  child: CustomPaint(
                    painter: Polygon(sides: _sidesAnimation.value),
                    child: SizedBox(
                      width: _radiusAnimation.value,
                      height: _radiusAnimation.value,
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class Polygon extends CustomPainter {
  final int sides;
  Polygon({required this.sides});
  @override
  void paint(Canvas canvas, Size size) {
    // to get the center of the size
    final center = Offset(size.width / 2, size.height / 2);
    // we get the angle of for the sides
    final angle = (2 * pi) / sides;
    // this is the brush that paints on the canvas
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;
    // this is the path to be painted
    final path = Path();
    final angles = List.generate(sides, (index) => index * angle);
    final radius = size.width / 2;
    path.moveTo(
      center.dx + radius * cos(0),
      center.dy + radius * sin(0),
    );
    for (final angle in angles) {
      path.lineTo(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      print(angle);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is Polygon && oldDelegate.sides != sides;
}
