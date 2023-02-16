import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi;

class Animation3D extends StatefulWidget {
  const Animation3D({super.key});

  @override
  State<Animation3D> createState() => _Animation3DState();
}

const widthAndHeight = 100.0;

class _Animation3DState extends State<Animation3D>
    with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();
    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    );

    _animation = Tween<double>(
      begin: 0,
      end: pi * 2,
    );
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..repeat();
    _yController
      ..reset()
      ..repeat();
    _zController
      ..reset()
      ..repeat();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation 3d'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: widthAndHeight,
            width: double.infinity,
          ),
          AnimatedBuilder(
            animation: Listenable.merge([
              _xController,
              _yController,
              _zController,
            ]),
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateY(_animation.evaluate(_yController))
                  ..rotateX(_animation.evaluate(_xController))
                  ..rotateZ(_animation.evaluate(_zController)),
                child: Stack(
                  children: [
                    //front side
                    Container(
                      color: Colors.red,
                      width: widthAndHeight,
                      height: widthAndHeight,
                    ),
                    //left side
                    Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()..rotateY(pi / 2),
                      child: Container(
                        color: Colors.yellow,
                        width: widthAndHeight,
                        height: widthAndHeight,
                      ),
                    ),
                    //right side
                    Transform(
                      alignment: Alignment.centerRight,
                      transform: Matrix4.identity()..rotateY(-pi / 2),
                      child: Container(
                        color: Colors.green,
                        width: widthAndHeight,
                        height: widthAndHeight,
                      ),
                    ),
                    //top side
                    Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()..rotateX(-pi / 2),
                      child: Container(
                        color: Colors.purple,
                        width: widthAndHeight,
                        height: widthAndHeight,
                      ),
                    ),
                    //bottom side
                    Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()..rotateX(pi / 2),
                      child: Container(
                        color: Colors.black,
                        width: widthAndHeight,
                        height: widthAndHeight,
                      ),
                    ),
                    //back side
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..translate(
                          Vector3(
                            0,
                            0,
                            -widthAndHeight,
                          ),
                        ),
                      child: Container(
                        color: Colors.blue,
                        width: widthAndHeight,
                        height: widthAndHeight,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
