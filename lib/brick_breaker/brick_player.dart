// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class BrickPlayer extends StatelessWidget {
  final playerX;
  final playerWidth; //out of 2
  const BrickPlayer({
    super.key,
    required this.playerX,
    required this.playerWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment:
          Alignment((2 * playerX + playerWidth) / (2 - playerWidth), 0.9),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.deepPurple,
        ),
        height: 10,
        width: MediaQuery.of(context).size.width * playerWidth / 2,
      ),
    );
  }
}
