import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:one_for_all/tap_puzzle/components/flip_animation.dart';

import '../components/list_of_items.dart';

class TapPuzzleHome extends StatefulWidget {
  const TapPuzzleHome({super.key});

  @override
  State<TapPuzzleHome> createState() => _TapPuzzleHomeState();
}

class _TapPuzzleHomeState extends State<TapPuzzleHome> {
  List<FlipController> flipController = [];
  List twoTaps = [];
  List twoTapsElement = [];

  @override
  void initState() {
    flipController.clear();
    flipController = List.generate(listOfItems.length, (i) => FlipController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('build rebuild');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tap Puzzle'),
      ),
      body: Container(
        // color: Colors.green,
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: listOfItems.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 30,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return (flipController.isNotEmpty)
                ? GestureDetector(
                    onTap: () async {
                      if (twoTaps.length < 2) {
                        flipController[index].flip();
                        twoTaps.add(index);
                        twoTapsElement.add(listOfItems[index]);
                        if (twoTaps.length == 2) {
                          if (twoTapsElement[0] == twoTapsElement[1]) {
                            twoTaps.clear();
                            twoTapsElement.clear();
                          } else {
                            await Future.delayed(
                                    const Duration(milliseconds: 800))
                                .then(
                              (value) {
                                flipController[twoTaps[0]].flip();
                                flipController[twoTaps[1]].flip();
                                twoTaps.clear();
                                twoTapsElement.clear();
                              },
                            );
                          }
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
                            listOfItems[index],
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
