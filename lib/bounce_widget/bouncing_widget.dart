import 'package:flutter/material.dart';
import 'package:one_for_all/flutter_animation/bounc_animation.dart';
import 'package:one_for_all/flutter_animation/bounce_animation.dart';

class BouncingWidget extends StatefulWidget {
  const BouncingWidget({super.key});

  @override
  State<BouncingWidget> createState() => _BouncingWidgetState();
}

class _BouncingWidgetState extends State<BouncingWidget> {
  bool animate = false;
  bool animate1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bouncing Widget'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Dance(
              animate: animate,
              delay: 5,
              child: const Text(
                'Dancing',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 50,
            ),
            Bounce(
              animate: animate1,
              child: const Text(
                'Bouncing',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                // animate1 = true;
                setState(() {});
              },
              child: const Text('Click to make text bounce'),
            ),
          ],
        ),
      ),
    );
  }
}
