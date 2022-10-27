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
                  // navigate();
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
      // backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        // alignment: Alignment.center,
        // height: double.infinity,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     fit: BoxFit.cover,
        //     image: AssetImage('assets/images/bg1.jpg'),
        //   ),
        // ),
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                // color: Colors.blue,
                child: const AnimatedColorText(
                  text: 'CARD FLIP MEMORY GAME',
                  colorsList: [Colors.blue, Colors.purple, Colors.red],
                  textStyle: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              // const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.18,
                ),
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
                      firstChild: const CircleAvatar(
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
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      // color: Colors.red,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(-0.5, 0.1),
                          end: Offset(0.5, 0.1),
                        ).animate(_animationController),
                        child: Image(
                          height: 50,
                          width: 50,
                          image: (_animationController.value < 1)
                              ? const AssetImage(
                                  'assets/gifs/itachi_loading.gif')
                              : const AssetImage('assets/gifs/itachi.gif'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: _animationController.value,
                        minHeight: 10,
                        backgroundColor: Colors.white,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      (_animationController.value < 1)
                          ? 'Loading..'
                          : 'Completed',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
