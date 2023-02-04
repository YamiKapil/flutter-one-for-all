import 'package:flutter/material.dart';
import 'dart:math' show pi;

enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();

    late Offset offset;
    late bool clockwise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
      default:
    }
    path.arcToPoint(
      offset,
      radius: Radius.elliptical(size.width / 2, size.height / 2),
      clockwise: clockwise,
    );
    path.close();
    return path;
  }
}

extension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;

  HalfCircleClipper({
    required this.side,
  });
  @override
  Path getClip(Size size) {
    try {
      return side.toPath(size);
    } catch (e) {
      throw Exception('Wrong size');
    }
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class ChainAnimation extends StatefulWidget {
  const ChainAnimation({super.key});

  @override
  State<ChainAnimation> createState() => _ChainAnimationState();
}

class _ChainAnimationState extends State<ChainAnimation>
    with TickerProviderStateMixin {
  late AnimationController _counterClockWiseRotationController;
  late Animation<double> _counterClockWiseRotationAnimation;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _counterClockWiseRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _counterClockWiseRotationAnimation = Tween<double>(
      begin: 0,
      end: -(pi / 2.0),
    ).animate(
      CurvedAnimation(
        parent: _counterClockWiseRotationController,
        curve: Curves.bounceOut,
      ),
    );

    // Flip Animation.....
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _flipAnimation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(
      CurvedAnimation(
        parent: _flipController,
        curve: Curves.bounceOut,
      ),
    );

    // status listner
    _counterClockWiseRotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(
          begin: _flipAnimation.value,
          end: _flipAnimation.value + pi,
        ).animate(
          CurvedAnimation(
            parent: _flipController,
            curve: Curves.bounceOut,
          ),
        );

        //reset the flip controller and start again
        _flipController
          ..reset()
          ..forward();
      }
    });

    _flipController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _counterClockWiseRotationAnimation = Tween<double>(
            begin: _counterClockWiseRotationAnimation.value,
            end: _counterClockWiseRotationAnimation.value + -(pi / 2.0),
          ).animate(
            CurvedAnimation(
              parent: _counterClockWiseRotationController,
              curve: Curves.bounceOut,
            ),
          );
          //reset the rotation animation
          _counterClockWiseRotationController
            ..reset()
            ..forward();
        }
      },
    );

    _counterClockWiseRotationController
      ..reset()
      ..forward.delayed(const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _counterClockWiseRotationController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(seconds: 1), () {
    //   _counterClockWiseRotationController
    //     ..reset()
    //     ..forward();
    // });
    // _counterClockWiseRotationController
    //   ..reset()
    //   ..forward.delayed(const Duration(seconds: 1));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chain Animation'),
      ),
      body: Center(
        child: AnimatedBuilder(
            animation: _counterClockWiseRotationController,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateZ(_counterClockWiseRotationAnimation.value),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _flipController,
                      builder: (context, child) {
                        return Transform(
                          alignment: Alignment.centerRight,
                          transform: Matrix4.identity()
                            ..rotateY(_flipAnimation.value),
                          child: ClipPath(
                            clipper: HalfCircleClipper(side: CircleSide.left),
                            child: Container(
                              height: 150,
                              width: 150,
                              color: Colors.blue,
                            ),
                          ),
                        );
                      },
                    ),
                    AnimatedBuilder(
                      animation: _flipController,
                      builder: (context, child) {
                        return Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()
                            ..rotateY(_flipAnimation.value),
                          child: ClipPath(
                            clipper: HalfCircleClipper(side: CircleSide.right),
                            child: Container(
                              height: 150,
                              width: 150,
                              color: Colors.red,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }),
      ),

      // body: Center(
      //   child: SizedBox(
      //     height: 200,
      //     width: 200,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Flexible(
      //           flex: 1,
      //           child: Container(
      //             decoration: const BoxDecoration(
      //               borderRadius: BorderRadius.only(
      //                 topLeft: Radius.circular(100),
      //                 bottomLeft: Radius.circular(100),
      //               ),
      //               color: Colors.blue,
      //             ),
      //           ),
      //         ),
      //         Flexible(
      //           flex: 1,
      //           child: Container(
      //             decoration: const BoxDecoration(
      //               borderRadius: BorderRadius.only(
      //                 topRight: Radius.circular(100),
      //                 bottomRight: Radius.circular(100),
      //               ),
      //               color: Colors.red,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
