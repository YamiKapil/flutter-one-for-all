import 'package:flutter/material.dart';

class PainterDemo extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw UnimplementedError();
  }
}

// demo rectangle
class DemoRectangle extends CustomPainter {
  final Color rectColor;

  DemoRectangle(this.rectColor);

  var rect = Rect.fromCenter(
    center: const Offset(100.0, 100.0),
    width: 50,
    height: 50,
  );

  @override
  void paint(Canvas canvas, Size size) {
    // var center = Offset(size.width / 2, size.height / 2);
    // canvas.drawRect(rect, Paint()..color = rectColor);
    // var paint = Paint()
    //   ..shader = LinearGradient(
    //     colors: [
    //       Colors.red,
    //       Colors.white,
    //     ],
    //   ).createShader(rect);
    // var rectangle =
    //     Rect.fromCenter(center: center, width: 300.0, height: 150.0);
    // // rounded rectangle
    // var roundedRectangle = RRect.fromRectAndRadius(
    //   Rect.fromCenter(center: center, width: 300.0, height: 150.0),
    //   const Radius.circular(32.0),
    // );
  }

  @override
  bool shouldRepaint(covariant DemoRectangle oldDelegate) {
    return rectColor != oldDelegate.rectColor;
  }
}

// void paint(Canvas canvas, Size size) {
//   var center = Offset(size.width/2, size.height/2);
//   var radius = 50.0;
//   var paint = Paint()..color = Colors.blue..style = PaintingStyle.fill;
//   canvas.drawCircle(center, radius, paint);
// }

// final rotationMatrix = Matrix4.identity()
//     ..rotateZ(0.5)
//     ..rotateX(0.5)
//     ..rotateY(0.5);
//   canvas.transform(rotationMatrix.storage);
