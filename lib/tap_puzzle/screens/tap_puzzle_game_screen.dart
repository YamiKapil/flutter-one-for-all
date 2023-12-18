import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:one_for_all/my_homepage.dart';
import 'package:one_for_all/tap_puzzle/components/flip_animation.dart';
import 'package:one_for_all/tap_puzzle/components/game_end_widget.dart';

import '../components/player_widget.dart';
import '../data/constants.dart';

class TapPuzzleGameScreen extends StatefulWidget {
  final int players;
  const TapPuzzleGameScreen({
    super.key,
    required this.players,
  });

  @override
  State<TapPuzzleGameScreen> createState() => _TapPuzzleGameScreenState();
}

class _TapPuzzleGameScreenState extends State<TapPuzzleGameScreen>
    with SingleTickerProviderStateMixin {
  List<FlipController> flipController = [];
  List twoTaps = [];
  List twoTapsElement = [];
  List totalItems = [];
  final random = math.Random();
  dynamic images;
  dynamic player = -1;
  int player1Score = 0;
  int player2Score = 0;
  int player3Score = 0;
  int player4Score = 0;
  List numberOfPlayers = [];
  List<Color> bgColor = [];
  late AnimationController colorAnimation;
  late Animation<double> animation;
  bool gameStarted = false;

  @override
  void initState() {
    images = listOfItems..shuffle();
    setPlayers();
    player = numberOfPlayers[0];
    // startAnimation();
    setPlayerBgColor();
    flipController.clear();
    flipController = List.generate(listOfItems.length, (i) => FlipController());
    colorAnimation = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    animation = Tween<double>(
      begin: 0,
      end: 30 * math.pi,
    ).animate(colorAnimation)
      ..addListener(() {
        // setState(() {});
      });
    changeBackgroundColor();
    super.initState();
  }

  startAnimation() {
    colorAnimation = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    animation = Tween<double>(
      begin: 0,
      end: 30 * math.pi,
    ).animate(colorAnimation)
      ..addListener(() {
        // setState(() {});
      });
    // textAnimation = AnimationController(
    //   duration: const Duration(
    //     seconds: 2,
    //   ),
    //   vsync: this,
    // );
    // animation = CurvedAnimation(parent: textAnimation, curve: Curves.bounceOut);
  }

  changeBackgroundColor() {
    colorAnimation.forward();
  }

  setPlayers() {
    // if (widget.players == 2) {
    numberOfPlayers = List.generate(
      widget.players,
      // (index) => 'Player${index + 1}',
      (index) => index,
    );
    // }
  }

  setPlayerBgColor() {
    for (var i = 0; i <= numberOfPlayers.length - 1; i++) {
      bgColor.add(playerBgColor[i]);
    }
  }

  resetGame() {
    setState(() {
      twoTaps.clear();
      twoTapsElement.clear();
      for (var i = 0; i < totalItems.length; i++) {
        flipController[i].isFront = true;
      }
      player = numberOfPlayers[0];
      player1Score = 0;
      player2Score = 0;
      player3Score = 0;
      player4Score = 0;
      images = listOfItems..shuffle();
      totalItems.clear();
      gameStarted = false;
    });
  }

  @override
  void dispose() {
    flipController.map((e) => e.dispose());
    colorAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(player1Score.toString(), name: 'score1');
    log(player2Score.toString(), name: 'score2');
    log(player3Score.toString(), name: 'score3');
    log(player4Score.toString(), name: 'score4');
    // log((player1Score > player2Score &&
    //         player2Score >= player3Score &&
    //         player3Score >= player4Score)
    //     .toString());
    // log((player2Score > player3Score && player2Score > player4Score).toString(),
    //     name: 'two win');
    // log((player3Score > player4Score).toString(), name: 'three win');
    log('build rebuild');
    log(player.toString());
    log(numberOfPlayers.length.toString(), name: 'number of players');
    log(bgColor.toString(), name: 'bg color');
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   centerTitle: true,
        //   title: const Text(
        //     'Tap Puzzle',
        //     style: TextStyle(color: Colors.white),
        //   ),
        //   leading: GestureDetector(
        //     onTap: () => Navigator.pushAndRemoveUntil(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => const MyHomePage(),
        //       ),
        //       (route) => false,
        //     ),
        //     child: const Icon(Icons.arrow_back,color: Colors.white),
        //   ),
        // ),
        body: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Container(
            height: double.infinity,
            color: (player == numberOfPlayers[0])
                ? (gameStarted)
                    ? bgColor.last
                    : Colors.white
                : (player == numberOfPlayers[1])
                    ? bgColor[player - 1]
                    : (player == numberOfPlayers[2] &&
                            numberOfPlayers[2] != null)
                        ? bgColor[player - 1]
                        : (player == numberOfPlayers[3] &&
                                numberOfPlayers[3] != null)
                            ? bgColor[player - 1]
                            : Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: Stack(
              // mainAxisSize: MainAxisSize.min,
              children: [
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: PlayerWidget(
                //     color: Colors.red,
                //     score: player1Score,
                //   ),
                // ),
                Center(
                  child: AnimatedBuilder(
                      animation: animation,
                      builder: (context, _) {
                        return Transform.scale(
                          scale: animation.value,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: (player == numberOfPlayers[0])
                                  ? Colors.red
                                  : (player == numberOfPlayers[1])
                                      ? Colors.blue
                                      : (player == numberOfPlayers[2] &&
                                              numberOfPlayers[2] != null)
                                          ? Colors.green
                                          : (player == numberOfPlayers[3] &&
                                                  numberOfPlayers[3] != null)
                                              ? Colors.orange
                                              : Colors.white,
                            ),
                            alignment: Alignment.center,
                          ),
                        );
                      }),
                ),
                // const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: GridView.builder(
                    itemCount: images.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (kIsWeb) ? 6 : 4,
                      mainAxisSpacing: 25,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return (flipController.isNotEmpty)
                          ? GestureDetector(
                              onTap: () async {
                                if (twoTaps.length < 2 &&
                                    !totalItems.contains(index)) {
                                  flipController[index].flip();
                                  log(flipController[index].value.toString(),
                                      name: 'flipedd');
                                  twoTaps.add(index);
                                  totalItems.add(index);
                                  twoTapsElement.add(listOfItems[index]);
                                  if (twoTaps.length == 2) {
                                    if (twoTapsElement[0] ==
                                        twoTapsElement[1]) {
                                      if (player == numberOfPlayers[0]) {
                                        setState(() {
                                          player1Score++;
                                        });
                                      } else if (player == numberOfPlayers[1]) {
                                        setState(() {
                                          player2Score++;
                                        });
                                      } else if (player == numberOfPlayers[2]) {
                                        setState(() {
                                          player3Score++;
                                        });
                                      } else if (player == numberOfPlayers[3]) {
                                        setState(() {
                                          player4Score++;
                                        });
                                      }
                                      if (listOfItems.length !=
                                          totalItems.length) {
                                        twoTaps.clear();
                                        twoTapsElement.clear();
                                      } else {}
                                    } else {
                                      await Future.delayed(
                                              const Duration(milliseconds: 800))
                                          .then(
                                        (value) {
                                          flipController[twoTaps[0]].flip();
                                          flipController[twoTaps[1]].flip();
                                          totalItems.remove(twoTaps[0]);
                                          totalItems.remove(twoTaps[1]);
                                          // if (player == Players.player1) {
                                          //   setState(() {
                                          //     player = Players.player2;
                                          //   });
                                          // } else {
                                          //   setState(() {
                                          //     player = Players.player1;
                                          //   });
                                          // }
                                          if (player <
                                              numberOfPlayers.length - 1) {
                                            setState(() {
                                              player++;
                                              colorAnimation.value = 0;
                                              gameStarted = true;
                                            });
                                            changeBackgroundColor();
                                          } else {
                                            setState(() {
                                              player = numberOfPlayers[0];
                                              colorAnimation.value = 0;
                                            });
                                            // colorAnimation.reverse();
                                            changeBackgroundColor();
                                          }
                                          twoTaps.clear();
                                          twoTapsElement.clear();
                                        },
                                      );
                                    }
                                  }
                                } else {
                                  if (totalItems.length == listOfItems.length) {
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (context) => AlertDialog(
                                    //     content: (player1Score > player2Score &&
                                    //             player2Score > player3Score &&
                                    //             player3Score > player4Score)
                                    //         ? const Text(
                                    //             'Congratulation Player1. You Won!!')
                                    //         : (player2Score > player3Score &&
                                    //                 player3Score > player4Score)
                                    //             ? const Text(
                                    //                 'Congratulation Player2. You Won!!')
                                    //             : (player3Score > player4Score)
                                    //                 ? const Text(
                                    //                     'Congratulation Player3. You Won!!')
                                    //                 : const Text(
                                    //                     'Congratulation Player4. You Won!!',
                                    //                   ),
                                    //     actions: [
                                    //       TextButton(
                                    //         onPressed: () {
                                    //           Navigator.of(context).pop();
                                    //         },
                                    //         child: const Text('Cancel'),
                                    //       ),
                                    //       TextButton(
                                    //         onPressed: () {
                                    //           Navigator.of(context).pop();
                                    //         },
                                    //         child: const Text('Try Again'),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // );
                                  }
                                }
                                // if (twoTaps.length > 2) {
                                //   log('tap clear3');
                                //   twoTaps.clear();
                                //   twoTapsElement.clear();
                                // }
                              },
                              child: FlipAnimation(
                                controller: flipController[index],
                                firstChild: const CircleAvatar(
                                  radius: 45,
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 40,
                                    foregroundImage: AssetImage(
                                      'assets/images/card_bg.jpg',
                                    ),
                                  ),
                                ),
                                secondChild: CircleAvatar(
                                  radius: 45,
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 40,
                                    foregroundImage: AssetImage(
                                      images[index],
                                      // images[index],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                ),
                // const SizedBox(height: 10),
                if (totalItems.length == listOfItems.length)
                  Center(
                    child: GameEndWidget(
                      onPlayTap: () => resetGame(),
                      onMenuTap: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage(),
                        ),
                        (route) => false,
                      ),
                    ),
                  ),
                if (totalItems.length == listOfItems.length)
                  (player1Score > player2Score &&
                          player1Score > player3Score &&
                          player1Score > player4Score)
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Transform.rotate(
                            alignment: Alignment.bottomRight,
                            angle: -math.pi / 4,
                            child: Image.asset(
                              'assets/gifs/winner.gif',
                              height: 50,
                            ),
                          ),
                        )
                      : (player2Score > player3Score &&
                              player2Score > player4Score)
                          ? Align(
                              alignment: Alignment.bottomRight,
                              child: Transform.rotate(
                                alignment: Alignment.topLeft,
                                angle: -math.pi / 4,
                                child: Image.asset(
                                  'assets/gifs/winner.gif',
                                  height: 50,
                                ),
                              ),
                            )
                          : (player3Score > player4Score)
                              ? Align(
                                  alignment: Alignment.topRight,
                                  child: Transform.rotate(
                                    alignment: Alignment.bottomLeft,
                                    angle: math.pi / 4,
                                    child: Image.asset(
                                      'assets/gifs/winner.gif',
                                      height: 50,
                                    ),
                                  ),
                                )
                              : Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Transform.rotate(
                                    alignment: Alignment.topRight,
                                    angle: math.pi / 4,
                                    child: Image.asset(
                                      'assets/gifs/winner.gif',
                                      height: 50,
                                    ),
                                  ),
                                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: PlayerWidget(
                    color: Colors.red,
                    score: player1Score,
                  ),
                ),
                if (numberOfPlayers.length == 3 || numberOfPlayers.length == 4)
                  Align(
                    alignment: Alignment.topRight,
                    child: PlayerWidget(
                      color: Colors.green,
                      score: player3Score,
                    ),
                  ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: PlayerWidget(
                    color: Colors.blue,
                    score: player2Score,
                  ),
                ),
                if (numberOfPlayers.length == 4)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: PlayerWidget(
                      color: Colors.orange,
                      score: player4Score,
                    ),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onLongPress: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const TapPuzzleMenuScreen(),
                      //   ),
                      //   (route) => false,
                      // );
                    },
                    child: const Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
