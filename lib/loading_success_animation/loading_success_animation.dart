import 'package:flutter/material.dart';
import 'dart:math';

class LoadingSuccessAnimation extends StatefulWidget {
  const LoadingSuccessAnimation({super.key});

  @override
  State<LoadingSuccessAnimation> createState() =>
      _LoadingSuccessAnimationState();
}

class _LoadingSuccessAnimationState extends State<LoadingSuccessAnimation>
    with TickerProviderStateMixin {
  late AnimationController _loadingController;
  late AnimationController _successController;
  late AnimationController _failureController;
  late AnimationController _fillController;
  late Animation _rotateAnimation;
  late Animation _fillAnimation;
  late Animation _successAnimation;
  late Animation _failureAnimation;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _successController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _failureController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fillController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _rotateAnimation =
        Tween<double>(begin: 0.0, end: -pi * 2).animate(_loadingController);
    // _loadingController.addListener(() {});
    // TickerFuture tickerFuture = _loadingController.repeat();
    // tickerFuture.timeout(const Duration(seconds: 3), onTimeout: () {
    //   isLoading = false;
    //   _loadingController.forward(from: 0);
    //   _loadingController.stop(canceled: true);
    //   setState(() {});
    //   startSuccessAnimation();
    // });
    // _loadingController.forward();
    _fillController.forward();
    _fillController.addListener(() {
      if (_fillController.value > 0.5) {
        _successController.forward();
      }
    });
  }

  startSuccessAnimation() {
    _fillController.forward();
    _fillController.addListener(() {
      if (_fillController.value > 0.5) {
        _successController.forward();
      }
    });
  }

  @override
  void dispose() {
    _loadingController.dispose();
    _failureController.dispose();
    _successController.dispose();
    _fillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Future.delayed(const Duration(seconds: 2), () {
    //     setState(() {
    //       if (_loadingController.value == 1) {
    //         isLoading = false;
    //       }
    //     });
    //   });
    // });
    // if (isLoading == true) {
    //   _loadingController.repeat(reverse: false);
    // } else {
    //   startSuccessAnimation();
    // }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading Success Failure Animation'),
      ),
      body: Center(
        child: AnimatedBuilder(
            animation: Listenable.merge(
              [
                _loadingController,
                _fillController,
                _successController,
              ],
            ),
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotateAnimation.value,
                alignment: Alignment.center,
                child: CustomPaint(
                  foregroundPainter: LoadingPainter(),
                  painter: LoadingPainter(
                    animationProgress: _fillController.value,
                    successAnimation: _successController.value,
                    loadingCompleted: isLoading,
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class LoadingPainter extends CustomPainter {
  double? loadingAnimation;
  double? successAnimation;
  double? animationProgress;
  bool? loadingCompleted;
  LoadingPainter({
    this.loadingAnimation = 0.0,
    this.successAnimation,
    this.animationProgress = 0.0,
    this.loadingCompleted = false,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final successPath = Path();
    final rect = Rect.fromCircle(center: center, radius: radius);
    // creating line for success tick
    if (successAnimation != null) {
      successPath.moveTo(
        center.dx + radius / 3 * cos(3) * successAnimation!,
        center.dy + radius / 3 * sin(3.3) * successAnimation!,
      );
      successPath.lineTo(
        center.dx + radius / 3 * cos(2.2) * successAnimation!,
        center.dy + radius / 3 * sin(2.2) * successAnimation!,
      );
      successPath.lineTo(
        center.dx + radius / 2 * cos(0) * successAnimation!,
        center.dy + radius / 3 * sin(-0.5) * successAnimation!,
      );
    }
    // color for circle stroke
    final paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 10;
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

    canvas.drawArc(rect, -pi, -pi * 2 * animationProgress!, false, fillPaint);
    if (successAnimation != null) {
      canvas.drawPath(successPath, successPaint);
    }
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
