import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PathExample extends StatelessWidget {
  const PathExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TickerBuilder(builder: (context, sinceLast, total) {
      return CustomPaint(
        painter: PathPainter(total.inMilliseconds / 1000.0),
      );
    });
  }
}

class TickerBuilder extends StatefulWidget {
  // this builder function is used to create the widget which does
  // whatever it needs to based on the time which has elapsed or the
  // time since the last build. The former is useful for position-based
  // animations while the latter could be used for velocity-based
  // animations (i.e. oldPosition + (time * velocity) = newPosition).
  final Widget Function(
          BuildContext context, Duration sinceLastDraw, Duration totalElapsed)
      builder;

  const TickerBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  _TickerBuilderState createState() => _TickerBuilderState();
}

class _TickerBuilderState extends State<TickerBuilder> {
  // creates a ticker which ensures that the onTick function is called every frame
  late final Ticker _ticker = Ticker(onTick);

  // the total is the time that has elapsed since the widget was created.
  // It is initially set to zero as no time has elasped when it is first created.
  Duration total = Duration.zero;
  // this last draw time is saved during each draw cycle; this is so that
  // a time between draws can be calculated
  Duration lastDraw = Duration.zero;

  void onTick(Duration elapsed) {
    // by calling setState every time this function is called, we're
    // triggering this widget to be rebuilt on every frame.
    // This is where the indefinite animation part comes in!
    setState(() {
      total = elapsed;
    });
  }

  @override
  void initState() {
    super.initState();
    _ticker.start();
  }

  @override
  void didChangeDependencies() {
    _ticker.muted = !TickerMode.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final result = widget.builder(context, total - lastDraw, total);
    lastDraw = total;
    return result;
  }

  @override
  void dispose() {
    _ticker.stop();
    super.dispose();
  }
}

class PathPainter extends CustomPainter {
  final double pos;

  PathPainter(this.pos);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill
      ..strokeWidth = 0.0;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    Path path2 = Path();
    for (double i = 0; i < 200; i++) {
      // Random r = new Random();
      path2.moveTo(sin(i / 2.14 + pos) * 45 + 200, (i * 12));
      path2.lineTo(sin(i / 2.14 + pos) * 50 + 100, (i * 10));
      paint.style = PaintingStyle.stroke;
      paint.color = Colors.red;
      canvas.drawPath(path2, paint);
    }

    Path path = Path();
    paint.color = Colors.blue;
    paint.style = PaintingStyle.stroke;
    for (double i = 0; i < 30; i++) {
      path.moveTo(100, 50);
      // xC, yC, xC, yC, xEnd, yEnd
      path.cubicTo(
        -220,
        300,
        500,
        600 - i * 20,
        size.width / 2 + 50,
        size.height - 50,
      );
      canvas.drawPath(path, paint);
    }
  }

  // in this particular case, this is rather redundant as
  // the animation is happening every single frame. However,
  // in the case where it doesn't need to animate every frame, you
  // should implement it such that it only returns true if it actually
  // needs to redraw, as that way the flutter engine can optimize
  // its drawing and use less processing power & battery.
  @override
  bool shouldRepaint(PathPainter oldDelegate) => oldDelegate.pos != pos;
}
