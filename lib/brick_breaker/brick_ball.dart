import 'package:flutter/material.dart';

class BrickBall extends StatelessWidget {
  final double ballX;
  final double ballY;
  const BrickBall({
    super.key,
    required this.ballX,
    required this.ballY,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballX, ballY),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.deepPurple,
        ),
        height: 20,
        width: 20,
      ),
    );
  }
}
