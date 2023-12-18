import 'package:flutter/material.dart';

import 'painters.dart';

class PaintDemo extends StatefulWidget {
  const PaintDemo({super.key});

  @override
  State<PaintDemo> createState() => _PaintDemoState();
}

class _PaintDemoState extends State<PaintDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paint Demo'),
      ),
      body: Center(
        child: CustomPaint(
          // painter: LinePainter(),
          // painter: CirclePainter(),
          // painter: RectanglePainter(),
          // painter: OvalPainter(),
          // painter: ArcPainter(),
          painter: const QuadraticBezierCurvePainter(),
          child: Container(),
        ),
      ),
    );
  }
}

// painter: LinesPainter(),