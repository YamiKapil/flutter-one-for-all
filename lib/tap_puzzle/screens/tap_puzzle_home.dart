import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:one_for_all/my_homepage.dart';
import 'package:one_for_all/tap_puzzle/components/flip_animation.dart';
import 'package:one_for_all/tap_puzzle/components/game_end_widget.dart';

import '../components/list_of_items.dart';
import '../components/player_widget.dart';

class TapPuzzleHome extends StatefulWidget {
  final int players;
  const TapPuzzleHome({
    super.key,
    required this.players,
  });

  @override
  State<TapPuzzleHome> createState() => _TapPuzzleHomeState();
}

class _TapPuzzleHomeState extends State<TapPuzzleHome>
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
  late AnimationController textAnimation;
  late Animation<double> animation;

  @override
  void initState() {
    startAnimation();
    images = listOfItems..shuffle();
    setPlayers();
    player = numberOfPlayers[0];

    flipController.clear();
    flipController = List.generate(listOfItems.length, (i) => FlipController());
    super.initState();
  }

  startAnimation() {
    textAnimation = AnimationController(
      duration: const Duration(
        seconds: 2,
      ),
      vsync: this,
    );
    animation = CurvedAnimation(parent: textAnimation, curve: Curves.bounceOut);
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
    });
  }

  @override
  void dispose() {
    flipController.map((e) => e.dispose());
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
    log(numberOfPlayers.length.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tap Puzzle'),
        leading: GestureDetector(
          onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ),
            (route) => false,
          ),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        height: double.infinity,
        color: (player == numberOfPlayers[0])
            ? Colors.red
            : (player == numberOfPlayers[1])
                ? Colors.blue
                : (player == numberOfPlayers[2] && numberOfPlayers[2] != null)
                    ? Colors.green
                    : (player == numberOfPlayers[3] &&
                            numberOfPlayers[3] != null)
                        ? Colors.orange
                        : Colors.grey,
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
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: GridView.builder(
                itemCount: images.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
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
                                if (twoTapsElement[0] == twoTapsElement[1]) {
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
                                  if (listOfItems.length != totalItems.length) {
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
                                      if (player < numberOfPlayers.length - 1) {
                                        setState(() {
                                          player++;
                                        });
                                      } else {
                                        setState(() {
                                          player = numberOfPlayers[0];
                                        });
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
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.blue,
                              child: CircleAvatar(
                                radius: 40,
                                foregroundImage: AssetImage(
                                  'assets/images/card_bg.jpg',
                                ),
                              ),
                            ),
                            secondChild: CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.blue,
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
            const SizedBox(height: 10),
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
          ],
        ),
      ),
    );
  }
}