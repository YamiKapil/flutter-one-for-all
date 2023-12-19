import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedColorPallete extends StatefulWidget {
  const AnimatedColorPallete({super.key});

  @override
  State<AnimatedColorPallete> createState() => _AnimatedColorPalleteState();
}

class _AnimatedColorPalleteState extends State<AnimatedColorPallete> {
  List<Color> currentPallete = generateRandomPalette();

  static List<Color> generateRandomPalette() {
    final random = Random();
    return List.generate(
      5,
      (index) => Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      ),
    );
  }

  void regeneratePalette() {
    setState(() {
      currentPallete = generateRandomPalette();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color palette generator'),
      ),
      body: Center(
        child: Column(
          children: [
            for (Color color in currentPallete)
              AnimatedContainer(
                duration: const Duration(milliseconds: 550),
                curve: Curves.fastEaseInToSlowEaseOut,
                width: 100,
                height: 100,
                color: color,
                margin: const EdgeInsets.all(8),
                onEnd: () {
                  regeneratePalette();
                },
              ),
            ElevatedButton(
              onPressed: regeneratePalette,
              child: const Text('Re generate palette'),
            ),
          ],
        ),
      ),
    );
  }
}
