import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:one_for_all/tap_puzzle/data/audio_provider.dart';
import 'package:one_for_all/tap_puzzle/data/constants.dart';
import 'package:one_for_all/tap_puzzle/screens/settings/tap_puzzle_settings.dart';

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
  late ValueNotifier<bool> isPlaying;
  final player = AudioPlayer();
  final player2 = AudioPlayer();

  @override
  void initState() {
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 700),
    // );
    _crossFadeStateNotifier = ValueNotifier(CrossFadeState.showFirst);
    isPlaying = ValueNotifier(true);
    player.setReleaseMode(ReleaseMode.loop);
    player.setVolume(0.3);
    player2.setVolume(0.3);
    playBgm();
    super.initState();
  }

  void showMainMenu() {
    _crossFadeStateNotifier.value = CrossFadeState.showFirst;
  }

  void showSettings() {
    _crossFadeStateNotifier.value = CrossFadeState.showSecond;
  }

  void playBgm() {
    isPlaying.value = true;
    player.play(AssetSource(narutoBgm));
  }

  void stopBgm() {
    player.stop();
    isPlaying.value = false;
  }

  @override
  void dispose() {
    player.dispose();
    player2.dispose();
    super.dispose();
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
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).padding.top,
                horizontal: 20,
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: ValueListenableBuilder(
                    valueListenable: isPlaying,
                    builder: (context, val, _) {
                      return IconButton(
                        onPressed: () {
                          val == true ? stopBgm() : playBgm();
                        },
                        icon: Icon(
                          (val == true) ? Icons.volume_up : Icons.volume_off,
                        ),
                        iconSize: 40,
                      );
                    }),
              ),
            ),
            Padding(
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
                          player: player2,
                        ),
                        secondChild: TapPuzzleSettings(
                          player: player2,
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
          ],
        ),
      ),
    );
  }
}
