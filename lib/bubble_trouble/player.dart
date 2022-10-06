import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  final double playerX;
  const MyPlayer({super.key, required this.playerX});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(playerX, 1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          // color: Colors.blue,
          child: Image.asset(
            'gifs/itachi.gif',
            height: 80,
          ),
        ),
      ),
    );
  }
}
