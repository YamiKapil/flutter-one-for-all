import 'package:flutter/material.dart';
import 'package:one_for_all/common_components/animated_color_text.dart';
import 'package:one_for_all/tap_puzzle/data/constants.dart';
import 'package:one_for_all/tap_puzzle/screens/tap_puzzle_menu_screen.dart';

import '../components/flip_animation.dart';

class TapPuzzleSplash extends StatefulWidget {
  const TapPuzzleSplash({super.key});

  @override
  State<TapPuzzleSplash> createState() => _TapPuzzleSplashState();
}

class _TapPuzzleSplashState extends State<TapPuzzleSplash>
    with SingleTickerProviderStateMixin {
  List<FlipController> flipController = [];
  late AnimationController _animationController;
  dynamic images;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {
          // log(_animationController.value.toString());
        });
      });
    //   _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController)
    // ..addListener(() {
    //   setState(() {
    //     print("Animation value: ${_animation.value}");
    //   });
    // });
    images = listOfItems..shuffle();
    flipController.clear();
    flipController = List.generate(4, (i) => FlipController());
    startAnimation();

    super.initState();
  }

  startAnimation() {
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      _animationController
          .animateTo(0.2)
          .then((value) => flipController[0].flip())
          .then((value) => _animationController
              .animateTo(0.4)
              .then((value) => flipController[3].flip()))
          .then((value) => _animationController
              .animateTo(0.6)
              .then((value) => flipController[1].flip()))
          .then((value) => _animationController
              .animateTo(0.8)
              .then((value) => flipController[2].flip())
              .then(
                (value) => _animationController.animateTo(1.0).then((value) {
                  for (var i = 0; i < 4; i++) {
                    flipController[i].flip();
                  }
                  navigate();
                }),
              ));
    });
    // log(_animationController.value.toString(), name: 'ani;amtion value');
    // if (_animationController.value == 0.1) {
    //   flipController[0].flip();
    // }
    // if (_animationController.value == 0.3) {
    //   flipController[1].flip();
    // }
    // if (_animationController.value == 0.6) {
    //   flipController[2].flip();
    // }
    // if (_animationController.value == 0.9) {
    //   flipController[3].flip();
    // }
    // if (_animationController.value == 1.0) {
    //   // flipController[0].flip();
    //   // flipController[1].flip();
    //   // flipController[2].flip();
    //   // flipController[3].flip();
    //   for (var i = 0; i < 4; i++) {
    //     flipController[i].flip();
    //   }
    // }
  }

  @override
  void dispose() {
    _animationController.dispose();
    flipController.map((e) => e.dispose());
    super.dispose();
  }

  navigate() {
    Future.delayed(const Duration(milliseconds: 500)).then(
      (value) =>
          //  _animationController.value == 1 ?
          Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const TapPuzzleMenuScreen(),
        ),
        // (route) => false)
        // : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AnimatedColorText(
                text: 'TAP PUZZLE',
                colorsList: [Colors.blue, Colors.purple, Colors.red],
                textStyle: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.25),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return FlipAnimation(
                      controller: flipController[index],
                      firstChild: CircleAvatar(
                        radius: 45,
                        foregroundImage: AssetImage(
                          'assets/images/card_bg.jpg',
                        ),
                      ),
                      secondChild: CircleAvatar(
                        radius: 45,
                        foregroundImage: AssetImage(
                          images[index],
                          // images[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
