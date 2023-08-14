import 'package:flutter/material.dart';

class TextToMoveUp extends StatefulWidget {
  const TextToMoveUp({super.key});

  @override
  TextToMoveUpState createState() => TextToMoveUpState();
}

class TextToMoveUpState extends State<TextToMoveUp>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, -0.4))
            .animate(_animationController);

    _animationController.forward().whenComplete(() {
      // put here the stuff you wanna do when animation completed!
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SlideTransition(
      position: _animation,
      child: const Center(child: Text("My Text")),
    ));
  }
}
