import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:one_for_all/tap_puzzle/components/flip_animation.dart';

import '../components/list_of_items.dart';
import '../components/player_widget.dart';

class TapPuzzleHome extends StatefulWidget {
  const TapPuzzleHome({super.key});

  @override
  State<TapPuzzleHome> createState() => _TapPuzzleHomeState();
}

class _TapPuzzleHomeState extends State<TapPuzzleHome> {
  List<FlipController> flipController = [];
  List twoTaps = [];
  List twoTapsElement = [];
  List totalItems = [];
  final random = math.Random();
  dynamic images;
  dynamic player;
  int player1Score = 0;
  int player2Score = 0;

  @override
  void initState() {
    images = listOfItems..shuffle();
    player = Players.player1;
    flipController.clear();
    flipController = List.generate(listOfItems.length, (i) => FlipController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('build rebuild');
    log(player.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tap Puzzle'),
      ),
      body: Container(
        height: double.infinity,
        color: (player == Players.player1)
            ? Colors.red
            : (player == Players.player2)
                ? Colors.green
                : Colors.grey,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: PlayerWidget(
                color: Colors.red,
                score: player1Score,
              ),
            ),
            const SizedBox(height: 10),
            GridView.builder(
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
                            twoTaps.add(index);
                            totalItems.add(index);
                            twoTapsElement.add(listOfItems[index]);
                            if (twoTaps.length == 2) {
                              if (twoTapsElement[0] == twoTapsElement[1]) {
                                if (player == Players.player1) {
                                  setState(() {
                                    player1Score++;
                                  });
                                } else {
                                  setState(() {
                                    player2Score++;
                                  });
                                }
                                if (listOfItems.length != totalItems.length) {
                                  twoTaps.clear();
                                  twoTapsElement.clear();
                                }
                              } else {
                                await Future.delayed(
                                        const Duration(milliseconds: 800))
                                    .then(
                                  (value) {
                                    flipController[twoTaps[0]].flip();
                                    flipController[twoTaps[1]].flip();
                                    totalItems.remove(twoTaps[0]);
                                    totalItems.remove(twoTaps[1]);
                                    if (player == Players.player1) {
                                      setState(() {
                                        player = Players.player2;
                                      });
                                    } else {
                                      setState(() {
                                        player = Players.player1;
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
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: (player1Score > player2Score)
                                      ? const Text(
                                          'Congratulation Player1. You Won!!')
                                      : const Text(
                                          'Congratulation Player2. You Won!!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Try Again'),
                                    ),
                                  ],
                                ),
                              );
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
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: PlayerWidget(
                color: Colors.green,
                score: player2Score,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
