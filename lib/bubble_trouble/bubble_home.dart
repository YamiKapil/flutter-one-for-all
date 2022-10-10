import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_for_all/bubble_trouble/balls.dart';
import 'package:one_for_all/bubble_trouble/button.dart';
import 'package:one_for_all/bubble_trouble/missile.dart';
import 'package:one_for_all/bubble_trouble/player.dart';

class BubbleHome extends StatefulWidget {
  const BubbleHome({super.key});

  @override
  State<BubbleHome> createState() => _BubbleHomeState();
}

enum Direction {
  left,
  right,
}

class _BubbleHomeState extends State<BubbleHome> {
  //player variable
  static double playerX = 0;

  // missile variable
  double missileX = playerX;
  double missileHeight = 0;
  bool midShot = false;

  // ball variables
  double ballX = 0.5;
  double ballY = 1; // ball on the ground if 1.
  var ballDirection = Direction.left;

  void startGame() {
    double time = 0;
    double height = 0;
    double velocity = 60; // how strong the jump is
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      // quadratic equation that models a bounce (upside down parabola)
      height = -5 * time * time + velocity * time;

      // if ball reaches the ground reset the jump
      if (height < 0) {
        time = 0;
      }
      // update the new ball position
      setState(() {
        ballY = heightToCoordinate(height);
      });

      // ........
      // ball moves only left and right..
      // if the ball hits the left wall, then change direction to right
      if (ballX - 0.005 < -1) {
        ballDirection = Direction.right;
        // if the ball hits the right wall, then change direction to left
      } else if (ballX + 0.005 > 1) {
        ballDirection = Direction.left;
      }
      // move ball in the correct direction
      if (ballDirection == Direction.left) {
        setState(() {
          ballX -= 0.005;
        });
      } else if (ballDirection == Direction.right) {
        setState(() {
          ballX += 0.005;
        });
      }
      //..

      // check if the ball hits the player
      if (playerDies()) {
        timer.cancel();
        _showDialog();
      }

      // keep the time going
      time += 0.1;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade700,
          title: const Center(
            child: Text(
              'You ded bro!!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  void moveLeft() {
    setState(() {
      if (playerX - 0.1 < -1) {
        // do nothing
        // playerX == -1;
      } else {
        playerX -= 0.1;
      }
      // only make the X coordinate the same when it isnot in the
      // middle of the shot
      if (!midShot) {
        missileX = playerX;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (playerX + 0.1 > 1) {
        // do nothing
        // playerX == 1;
      } else {
        playerX += 0.1;
      }
      if (!midShot) {
        missileX = playerX;
      }
    });
  }

  void fireMissile() {
    if (!midShot) {
      Timer.periodic(const Duration(milliseconds: 20), (timer) {
        //shot fired
        midShot = true;
        setState(() {
          // missile grows till it hit the top of the screen
          missileHeight += 10;
        });
        //stop missile when it reaches to top and reset it
        if (missileHeight > MediaQuery.of(context).size.height * 3 / 4) {
          resetMissile();
          timer.cancel();
        }

        //check if missile hit the ball
        if (ballY > heightToCoordinate(missileHeight) &&
            (ballX - missileX).abs() < 0.03) {
          resetMissile();
          ballX = 5;
          timer.cancel();
        }
      });
    }
  }

  void resetMissile() {
    missileX = playerX;
    missileHeight = 0;
    midShot = false;
  }

  // converts height to a coordinate
  double heightToCoordinate(double height) {
    double totalHeight = MediaQuery.of(context).size.height * 3 / 4;
    double position = 1 - 2 * height / totalHeight;
    return position;
  }

  bool playerDies() {
    // if the ball position and the player position are the same
    // the player dies
    if ((ballX - playerX).abs() < 0.05 && ballY > 0.95) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bubble Trouble'),
      ),
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (event) {
          if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
            moveLeft();
          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
            moveRight();
          }
          if (event.isKeyPressed(LogicalKeyboardKey.space) ||
              event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
            fireMissile();
          }
        },
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.pink.shade100,
                child: Center(
                  child: Stack(
                    children: [
                      Missile(missileX: missileX, missileHeight: missileHeight),
                      Balls(ballX: ballX, ballY: ballY),
                      MyPlayer(playerX: playerX),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Buttons(
                      icon: Icons.play_arrow,
                      function: startGame,
                    ),
                    Buttons(
                      icon: Icons.arrow_back,
                      function: moveLeft,
                    ),
                    Buttons(
                      icon: Icons.arrow_upward,
                      function: fireMissile,
                    ),
                    Buttons(
                      icon: Icons.arrow_forward,
                      function: moveRight,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
