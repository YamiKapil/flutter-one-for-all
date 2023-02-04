import 'package:flutter/material.dart';

class BrickBarrier extends StatelessWidget {
  final double barrierHeight;
  final double barrierXAxis;
  final double barrierYAxis;
  final Color color;

  const BrickBarrier({
    super.key,
    required this.barrierHeight,
    required this.barrierXAxis,
    required this.barrierYAxis,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final width = (screenWidth / 6) * (barrierHeight / 100);
    return AnimatedContainer(
      duration: const Duration(),
      alignment: Alignment(barrierXAxis, barrierYAxis),
      child: Container(
        width: width,
        height: 20,
        decoration: BoxDecoration(
          // color: color,
          color: Colors.black,
          // border: Border.all(
          //   width: 10,
          //   color: Colors.green[800]!,
          // ),
          // borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
