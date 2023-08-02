import 'dart:math';

import 'package:flutter/material.dart';

import 'like_animation.dart';

class LikeAnimationScreen extends StatefulWidget {
  const LikeAnimationScreen({super.key});

  @override
  State<LikeAnimationScreen> createState() => _LikeAnimationScreenState();
}

class _LikeAnimationScreenState extends State<LikeAnimationScreen> {
  bool isLikeAnimating = false;
  List<int> userId = [1, 2, 4, 6, 8, 10];
  int id = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Like Animation')),
      body: Column(
        children: [
          GestureDetector(
            onDoubleTap: () async {
              id = Random().nextInt(10);
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: Colors.blue,
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  // child: Image.network(
                  //   widget.snap['postUrl'],
                  //   fit: BoxFit.fill,
                  // ),
                ),
                AnimatedOpacity(
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
                )
              ],
            ),
          ),
          LikeAnimation(
            isAnimating: userId.contains(id),
            smallLike: true,
            child: IconButton(
              onPressed: () async {},
              icon: userId.contains(id)
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(Icons.favorite_border_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
