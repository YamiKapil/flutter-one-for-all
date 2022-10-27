import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:one_for_all/tap_puzzle/screens/tap_puzzle_settings.dart';

import 'tap_puzzle_main_menu.dart';

class TapPuzzleMenuScreen extends StatefulWidget {
  const TapPuzzleMenuScreen({super.key});

  @override
  State<TapPuzzleMenuScreen> createState() => _TapPuzzleMenuScreenState();
}

class _TapPuzzleMenuScreenState extends State<TapPuzzleMenuScreen>
    with SingleTickerProviderStateMixin {
  // late AnimationController _animationController;
  // late Animation _animation;
  bool isFirstChild = true;
  late ValueNotifier<CrossFadeState> _crossFadeStateNotifier;

  @override
  void initState() {
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 700),
    // );
    _crossFadeStateNotifier = ValueNotifier(CrossFadeState.showFirst);
    super.initState();
  }

  void showMainMenu() {
    _crossFadeStateNotifier.value = CrossFadeState.showFirst;
  }

  void showSettings() {
    _crossFadeStateNotifier.value = CrossFadeState.showSecond;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/bg.jpg'),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.15,
            vertical: size.height * 0.2,
          ),
          child: Center(
            child: ValueListenableBuilder(
                valueListenable: _crossFadeStateNotifier,
                builder: (context, value, _) {
                  return AnimatedCrossFade(
                    firstChild: TapPuzzleMainMenu(
                      onSettingsPressed: showSettings,
                    ),
                    secondChild: TapPuzzleSettings(
                      onBackPressed: showMainMenu,
                    ),
                    crossFadeState: value,
                    duration: const Duration(milliseconds: 300),
                    secondCurve: Curves.easeIn,
                    firstCurve: Curves.easeIn,
                  );
                }),
          ),
        ),
      ),
    );
  }
}
