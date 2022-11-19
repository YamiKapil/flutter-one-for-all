import 'package:flutter/material.dart';
import 'package:one_for_all/amazing_brick/amazing_brick_game_screen.dart';
import 'package:one_for_all/common_components/rounded_button.dart';
import 'dart:math' as math;

class AmazingBrick extends StatefulWidget {
  const AmazingBrick({super.key});

  @override
  State<AmazingBrick> createState() => _AmazingBrickState();
}

class _AmazingBrickState extends State<AmazingBrick> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        width: double.infinity,
        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(height: 100),
            Text(
              'Flutter Amazing',
              style: TextStyle(
                fontSize: 35,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(
                  // angle: 90 * math.pi / 10,
                  angle: 0.8,
                  child: Icon(
                    Icons.square_sharp,
                    size: 50,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Brick',
                  style: TextStyle(
                    fontSize: 70,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 90),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedButton(
                  icon: Icons.play_arrow,
                  iconColor: Colors.white,
                  containerColor: Colors.green.shade300,
                  onPress: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AmazingBrickGameScreen(),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                RoundedButton(
                  icon: Icons.bar_chart_rounded,
                  iconColor: Colors.white,
                  containerColor: Colors.blue.shade300,
                ),
              ],
            ),
            const SizedBox(height: 100),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text('@ YamiKapil'),
            ),
          ],
        ),
      ),
    );
  }
}
