import 'package:flutter/material.dart';

class Bricks extends StatelessWidget {
  final double brickWidth;
  final double brickHeight;
  final double brickX;
  final double brickY;
  final bool brickBroken;

  const Bricks({
    super.key,
    required this.brickHeight,
    required this.brickWidth,
    required this.brickX,
    required this.brickY,
    required this.brickBroken,
  });

  @override
  Widget build(BuildContext context) {
    return (brickBroken)
        ? Container()
        : Container(
            // alignment: Alignment(brickX, brickY),
            alignment:
                Alignment((2 * brickX + brickWidth) / (2 - brickWidth), brickY),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.deepPurple,
              ),
              height: MediaQuery.of(context).size.height * brickHeight,
              width: MediaQuery.of(context).size.width * brickWidth,
            ),
          );
  }
}
