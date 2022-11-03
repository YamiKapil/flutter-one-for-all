import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_for_all/brick_breaker/brick_ball.dart';
import 'package:one_for_all/brick_breaker/brick_player.dart';
import 'package:one_for_all/brick_breaker/bricks.dart';
import 'package:one_for_all/brick_breaker/cover_screen.dart';
import 'package:one_for_all/brick_breaker/game_over_screen.dart';

class BrickBreakerHome extends StatefulWidget {
  const BrickBreakerHome({super.key});

  @override
  State<BrickBreakerHome> createState() => _BrickBreakerHomeState();
}

enum Direction { up, down, left, right }

class _BrickBreakerHomeState extends State<BrickBreakerHome> {
  //ball variables
  double ballX = 0;
  double ballY = 0;
  var ballXDirection = Direction.left;
  var ballYDirection = Direction.down;
  double ballXIncrements = 0.01;
  double ballYIncrements = 0.01;

  //payer variables
  double playerX = 0;
  double playerWidth = 0.3; // out of 2

  // game settings
  bool hasGameStarted = false;
  bool isGameOver = false;

  //brick variables
  static double firstBrickX = -1 + wallGap;
  static double firstBrickY = -0.9;
  static double brickWidth = 0.2; // out of 2
  static double brickHeight = 0.02; // out of 2
  static double brickGap = 0.01;
  static double numberofBricksInRow = 3;
  static double wallGap = 0.5 *
      (2 -
          numberofBricksInRow * brickWidth -
          (numberofBricksInRow - 1) * brickGap);
  bool brickBroken = false;

  List myBricks = [
    // [x,y,broken = true/false]
    [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false],
  ];

  // start game
  void startGame() {
    hasGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      // update direction
      updateDirection();
      // move ball up and down
      moveBall();
      // check if player is dead
      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
      }
      // check if brick is hit
      checkForBrokenBrick();
    });
  }

  void checkForBrokenBrick() {
    // check when the ball hits the brick
    for (int i = 0; i < myBricks.length; i++) {
      if (ballX >= myBricks[i][0] &&
          ballX <= myBricks[i][0] + brickWidth &&
          ballY <= myBricks[i][1] + brickHeight &&
          myBricks[i][2] == false) {
        setState(() {
          myBricks[i][2] = true;
          // since brick is broken , update direction of ball based on 
          // which side of the brick it hit
          // to do this calculate the distance of the ball form each of
          // the 4 sides of contact
          // the smallest distance is the side the ball has hit

          double leftSideDist = (myBricks[i][0]-ballX).abs();
          double rightSideDist = (myBricks[i][0]+brickWidth-ballX).abs();
          double topSideDist = (myBricks[i][1]-ballY).abs();
          double bottomSideDist = (myBricks[i][1]+brickHeight-ballY).abs();

          // if ball hit bottom side of brick
          ballYDirection = Direction.down;

          // if ball hit top side of brick
          ballYDirection = Direction.up;

          // if ball hit left side of brick
          ballYDirection = Direction.left;

          // if ball hit right side of brick
          ballYDirection = Direction.right;
        });
      }
    }
  }

  // is player dead
  bool isPlayerDead() {
    // player dies if ball reaches the bottom
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  // move ball
  void moveBall() {
    setState(() {
      // move horizontal
      if (ballXDirection == Direction.left) {
        ballX -= ballXIncrements;
      } else if (ballXDirection == Direction.right) {
        ballX += ballXIncrements;
      }

      // move vertical
      if (ballYDirection == Direction.down) {
        ballY += ballYIncrements;
      } else if (ballYDirection == Direction.up) {
        ballY -= ballYIncrements;
      }
    });
  }

  // update ball direction
  void updateDirection() {
    setState(() {
      // ball goes up when it hits the player
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballYDirection = Direction.up;
      }
      // ball goes down when it hits the top of the screen
      else if (ballY <= -1) {
        ballYDirection = Direction.down;
      }
      // ball goes left when it hits the right wall
      if (ballX >= 1) {
        ballXDirection = Direction.left;
      }
      // ball goes right when it hits the left wall
      else if (ballX <= -1) {
        ballXDirection = Direction.right;
      }
    });
  }

  // move player left
  void moveLeft() {
    if (!(playerX - 0.1 < -1)) {
      setState(() {
        playerX -= 0.1;
      });
    }
  }

  // move player right
  void moveRight() {
    if (!(playerX + playerWidth >= 1)) {
      setState(() {
        playerX += 0.1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: Stack(
            children: [
              // tap to play
              CoverScreen(hasGameStarted: hasGameStarted),
              // game over screem
              GameOverScreen(isGameOver: isGameOver),
              // ball
              BrickBall(ballX: ballX, ballY: ballY),
              // player
              BrickPlayer(
                playerX: playerX,
                playerWidth: playerWidth,
              ),
              // bricks
              Bricks(
                brickHeight: brickHeight,
                brickWidth: brickWidth,
                brickX: myBricks[0][0],
                brickY: myBricks[0][1],
                brickBroken: myBricks[0][2],
              ),
              Bricks(
                brickHeight: brickHeight,
                brickWidth: brickWidth,
                brickX: myBricks[1][0],
                brickY: myBricks[1][1],
                brickBroken: myBricks[1][2],
              ),
              Bricks(
                brickHeight: brickHeight,
                brickWidth: brickWidth,
                brickX: myBricks[2][0],
                brickY: myBricks[2][1],
                brickBroken: myBricks[2][2],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
