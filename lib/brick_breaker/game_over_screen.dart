import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final bool isGameOver;
  const GameOverScreen({super.key, required this.isGameOver});

  @override
  Widget build(BuildContext context) {
    return (!isGameOver)
        ? Container()
        : Container(
            alignment: const Alignment(0, -0.3),
            child: const Text(
              'G A M E  O V E R',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.deepPurple,
              ),
            ),
          );
  }
}
