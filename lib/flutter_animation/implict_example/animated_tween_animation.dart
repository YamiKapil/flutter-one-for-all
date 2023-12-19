import 'package:flutter/material.dart';

class PulsatingCircleAnimation extends StatefulWidget {
  const PulsatingCircleAnimation({super.key});

  @override
  State<PulsatingCircleAnimation> createState() =>
      _PulsatingCircleAnimationState();
}

class _PulsatingCircleAnimationState extends State<PulsatingCircleAnimation> {
  double begin = 0;
  double end = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pulsating Circle Animation'),
      ),
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: begin, end: end),
          duration: const Duration(milliseconds: 550),
          onEnd: () {
            setState(() {
              begin = 0;
              end = end == 200 ? 50 : 200;
            });
          },
          curve: Curves.fastOutSlowIn,
          builder: (context, object, child) {
            return Container(
              width: object,
              height: object,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.4),
                    blurRadius: object / 2,
                    spreadRadius: object / 4,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
