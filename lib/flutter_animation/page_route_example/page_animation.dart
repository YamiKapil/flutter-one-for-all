import 'dart:async';

import 'package:flutter/material.dart';

class PageAnimation extends StatefulWidget {
  const PageAnimation({super.key});

  @override
  State<PageAnimation> createState() => _PageAnimationState();
}

class _PageAnimationState extends State<PageAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    scaleAnimation = Tween<double>(begin: 1, end: 10).animate(controller);
    controller.addListener(() {
      if (controller.isCompleted) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const Destination(),
        //   ),
        // );
        // creating the fadded transtion for the navigation
        Navigator.push(
          context,
          // PageRouteBuilder(
          //   pageBuilder: (context, animation, secondaryAnimaton) {
          //     return const Destination();
          //   },
          //   transitionsBuilder:
          //       (context, animation, secondaryAnimation, child) {
          //     // the child is the returned widget of pageBuilder..
          //     return FadeTransition(
          //       opacity: animation,
          //       child: child,
          //     );
          //   },
          // ),
          MyCustomRouteTransition(
            route: const Destination(),
          ),
        );
        Timer(const Duration(milliseconds: 500), () {
          controller.reset();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            controller.forward();
          },
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Destination extends StatelessWidget {
  const Destination({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Go back'),
      ),
    );
  }
}

/// creating own route
class MyCustomRouteTransition extends PageRouteBuilder {
  final Widget route;
  MyCustomRouteTransition({required this.route})
      : super(
          pageBuilder: (context, animation, secondaryAnimaton) {
            return route;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // the child is the returned widget of pageBuilder..
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}
