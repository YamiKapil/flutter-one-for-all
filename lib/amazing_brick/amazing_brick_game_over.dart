import 'package:flutter/material.dart';
import 'package:one_for_all/common_components/rounded_button.dart';

class AmazingBrickGameOver extends StatelessWidget {
  const AmazingBrickGameOver({
    super.key,
    required this.playAgainTap,
    required this.exitTap,
  });
  final VoidCallback playAgainTap;
  final VoidCallback exitTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: playAgainTap,
            child: const Text(
              'Game Over',
              style: TextStyle(
                fontSize: 45,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Score',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        '10',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Best Score',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        '10',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Reward',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 10),
                      Icon(
                        Icons.diamond_outlined,
                        size: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          RoundedButton(
            onPress: playAgainTap,
            icon: Icons.play_arrow,
            iconColor: Colors.white,
            containerColor: Colors.green,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedButton(
                onPress: exitTap,
                icon: Icons.home,
                iconColor: Colors.white,
                containerColor: Colors.blue,
              ),
              const SizedBox(width: 20),
              const RoundedButton(
                // onPress: exitTap,
                icon: Icons.share,
                iconColor: Colors.white,
                containerColor: Colors.lightBlue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
