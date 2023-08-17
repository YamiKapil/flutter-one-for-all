import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:one_for_all/amazing_brick/amazing_brick_game_over.dart';

import 'game_barrier.dart';
import 'game_brick.dart';

class AmazingBrickGameScreen extends StatefulWidget {
  const AmazingBrickGameScreen({super.key});

  @override
  State<AmazingBrickGameScreen> createState() => _AmazingBrickGameScreenState();
}

class _AmazingBrickGameScreenState extends State<AmazingBrickGameScreen> {
  // brick properties
  static double brickY = 0.5;
  double brickX = 0;
  double time = 0;
  double height = 0;
  double initialHeight = brickY;
  bool onLeftTap = false;
  bool gameStarted = false;
  bool gameOver = false;
  // late final double screenWidth;
  // late final double screenHeight;
  Timer? _myTimer;

  // barrier properties
  double barrierYOneRight = 0;
  double barrierYOneLeft = 0;
  // double barrierYTwoRight = -0.8;
  // double barrierYTwoLeft = -0.8;
  double barrierYTwoRight = -1;
  double barrierYTwoLeft = -1;
  // double barrierYThreeRight = -1.6;
  // double barrierYThreeLeft = -1.6;
  double barrierYThreeRight = -2;
  double barrierYThreeLeft = -2;
  bool isBarrierTouched = false;

  // make left jump
  void jumpLeft() {
    time = 0;
    initialHeight = brickY;
    // Timer.periodic(const Duration(milliseconds: 50), (timer) {
    //   time += 0.05;
    //   height = -4.9 * time * time + 2 * time;
    //   setState(() {
    //     brickY = initialHeight - height;
    //     brickX -= 0.1;
    //   });
    //   if (brickY >= 0.5) {
    //     timer.cancel();
    //   }
    // });
  }

  // make right jump
  void jumpRight() {
    time = 0;
    initialHeight = brickY;
    // Timer.periodic(const Duration(milliseconds: 50), (timer) {
    //   time += 0.05;
    //   height = -4.9 * time * time + 2 * time;
    //   setState(() {
    //     brickY = initialHeight - height;
    //     brickX += 0.1;
    //   });
    //   if (brickY >= 0.5) {
    //     timer.cancel();
    //   }
    // });
  }

  // start game
  void startGame() {
    // final screenHeight = MediaQuery.of(context).size.height;
    gameStarted = true;
    _myTimer = Timer.periodic(const Duration(milliseconds: 90), (timer) {
      time += 0.05;
      // height = -4.9 * time * time + 2 * time;
      // height = -6.9 * (time * time) + 1.5 * time;
      height = -6.9 * (time * time) + 1.2 * time;
      setState(() {
        brickY = initialHeight - height;
        (onLeftTap) ? brickX -= 0.1 : brickX += 0.1;
        // moving barrier one right
        if (brickY < 0.3) {
          if (barrierYOneRight > 1) {
            // barrierYOneRight -= 1.8;
            barrierYOneRight -= 2.3;
          } else {
            barrierYOneRight += 0.05;
          }
          // moving barrier one left
          if (barrierYOneLeft > 1) {
            // barrierYOneLeft -= 1.8;
            barrierYOneLeft -= 2.3;
          } else {
            barrierYOneLeft += 0.05;
          }
          // moving barrier two right
          if (barrierYTwoRight > 1) {
            // barrierYTwoRight -= 1.8;
            barrierYTwoRight -= 2.3;
          } else {
            barrierYTwoRight += 0.05;
          }
          // moving barrier two left
          if (barrierYTwoLeft > 1) {
            // barrierYTwoLeft -= 1.8;
            barrierYTwoLeft -= 2.3;
          } else {
            barrierYTwoLeft += 0.05;
          }
          // moving barrier three right
          if (barrierYThreeRight > 1) {
            barrierYThreeRight -= 2.3;
          } else {
            barrierYThreeRight += 0.05;
          }
          // moving barrier three left
          if (barrierYThreeLeft > 1) {
            barrierYThreeLeft -= 2.3;
          } else {
            barrierYThreeLeft += 0.05;
          }
        }

        // check collision
        // if ((barrierYOneRight - brickY).abs() < 0.05 ||
        //     (barrierYOneLeft - brickY).abs() < 0.05 ||
        //     (barrierYTwoRight - brickY).abs() < 0.05 ||
        //     (barrierYTwoLeft - brickY).abs() < 0.05 ||
        //     (barrierYThreeRight - brickY).abs() < 0.05 ||
        //     (barrierYThreeLeft - brickY).abs() < 0.05) {
        //   isBarrierTouched = true;
        // }
        // if (barrierYOneRight < -0.19 && barrierYOneRight > -0.74) {
        //   if (brickY < -0.005 || brickY > 0.65) {
        //     isBarrierTouched = true;
        //   }
        // }
      });
      if (brickY > 0.9 || isBarrierTouched) {
        timer.cancel();
        gameStarted = false;
        gameOver = true;
        log('timer canceled');
      }
    });
  }

  void playAgain() {
    setState(() {
      // brick properties
      brickY = 0.5;
      brickX = 0;
      time = 0;
      height = 0;
      initialHeight = brickY;
      onLeftTap = false;
      gameStarted = false;
      gameOver = false;
      _myTimer = null;
      // barrier properties
      barrierYOneRight = 0;
      barrierYOneLeft = 0;
      barrierYTwoRight = -0.8;
      barrierYTwoLeft = -0.8;
      barrierYThreeRight = -1.6;
      barrierYThreeLeft = -1.6;
      isBarrierTouched = false;
    });
    startGame();
  }

  void exitTap() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            // color: Colors.red,
            alignment: Alignment(brickX, brickY),
            duration: const Duration(milliseconds: 0),
            child: const GameBrick(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  log('leftTapped');
                  setState(() {
                    onLeftTap = true;
                  });
                  (gameStarted) ? jumpLeft() : startGame();
                },
                child: Container(
                  // color: Colors.blue,
                  color: Colors.transparent,
                  height: screenHeight,
                  width: screenWidth / 2,
                ),
              ),
              GestureDetector(
                onTap: () {
                  log('rightTapped');
                  setState(() {
                    onLeftTap = false;
                  });
                  (gameStarted) ? jumpRight() : startGame();
                },
                child: Container(
                  height: screenHeight,
                  width: screenWidth / 2,
                  color: Colors.transparent,
                  // color: Colors.green,
                ),
              ),
            ],
          ),
          // barrier
          // barrierYOneRight
          BrickBarrier(
            barrierHeight: 180,
            barrierXAxis: 1,
            barrierYAxis: barrierYOneRight,
            color: Colors.blue,
          ),
          //barrierYOneLeft
          BrickBarrier(
            barrierHeight: 250,
            // barrierHeight: math.Random().nextInt(70) + 180,
            barrierXAxis: -1,
            barrierYAxis: barrierYOneLeft,
            color: Colors.blue,
          ),
          //barrierYTwoRight
          BrickBarrier(
            barrierHeight: 250,
            barrierXAxis: 1,
            barrierYAxis: barrierYTwoRight,
            color: Colors.red,
          ),
          //barrierYTwoLeft
          BrickBarrier(
            barrierHeight: 180,
            barrierXAxis: -1,
            barrierYAxis: barrierYTwoLeft,
            color: Colors.red,
          ),
          //barrierYThreeRight
          BrickBarrier(
            barrierHeight: 200,
            barrierXAxis: 1,
            barrierYAxis: barrierYThreeRight,
            color: Colors.orange,
          ),
          //barrierYThreeLeft
          BrickBarrier(
            barrierHeight: 230,
            barrierXAxis: -1,
            barrierYAxis: barrierYThreeLeft,
            color: Colors.orange,
          ),
          Align(
            alignment: const Alignment(-.9, -.9),
            child: GestureDetector(
              onTap: () {
                if (_myTimer != null) {
                  setState(() {
                    _myTimer!.cancel();
                    _myTimer = null;
                  });
                } else {
                  startGame();
                }
              },
              child: const Icon(
                Icons.pause_circle_outline_outlined,
                color: Colors.black,
                size: 40,
              ),
            ),
          ),
          if (gameOver)
            Container(
              height: double.infinity,
              color: Colors.transparent,
              alignment: const Alignment(0, 0),
              child: AmazingBrickGameOver(
                playAgainTap: playAgain,
                exitTap: exitTap,
              ),
            ),
        ],
      ),
    );
  }
}
