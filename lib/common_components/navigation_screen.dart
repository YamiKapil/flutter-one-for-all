import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_for_all/battery_level/battery_level.dart';
import 'package:one_for_all/flutter_animation/animation_home.dart';
import 'package:one_for_all/flutter_animation/animation_td.dart';
import 'package:one_for_all/flutter_animation/chain_animation.dart';
import 'package:one_for_all/flutter_animation/hero_animation.dart';
import 'package:one_for_all/responsive_row/responsive_row.dart';
import 'package:one_for_all/tap_puzzle/screens/player_selection_screen.dart';
import 'package:one_for_all/tap_puzzle/screens/tap_puzzle_game_screen.dart';
import 'package:one_for_all/tap_puzzle/screens/tap_puzzle_splash.dart';

import '../amazing_brick/amazing_brick.dart';
import '../animated_listview_builder/animate_image.dart';
import '../animated_listview_builder/animated_listview_builder.dart';
import '../animated_listview_builder/initial_animated_listview.dart';
import '../riverpod_guide/riverpod_guide_home.dart';
import '../text_to_speech/flutter_text_to_speech.dart';
import 'animated_list_item.dart';
import '../bubble_trouble/bubble_home.dart';
import '../habit_tracker/habit_home.dart';
import 'navigation_button.dart';

List<Widget> listOfScreens = [
  const NavigationButton(
    screenName: 'Bubble Trouble',
    navigationScreen: BubbleHome(),
    appImage: 'assets/gifs/itachi.gif',
  ),
  const NavigationButton(
    screenName: 'Habit Tracker',
    navigationScreen: HabitHome(),
    appImage: 'assets/images/yugi2.png',
  ),
  const NavigationButton(
    screenName: 'Responsive Row',
    navigationScreen: ResponsiveRow(),
    appImage: 'assets/images/yugi2.png',
  ),
  const NavigationButton(
    screenName: 'Battery Level',
    navigationScreen: BatteryLevel(),
    icon: Icons.battery_unknown,
  ),
  NavigationButton(
    screenName: 'Tap Puzzle',
    // navigationScreen: PlayerSelectionScreen(),
    navigationScreen: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TapPuzzleSplash(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: GoogleFonts.audiowide().fontFamily,
      ),
    ),
    // icon: Icons.touch_app_outlined,
    appImage: 'assets/images/card_bg.jpg',
    appColor: Colors.lime,
  ),
  const NavigationButton(
    screenName: 'Animated Listview',
    navigationScreen: AnimatedListViewBuilder(),
    icon: Icons.list_alt_outlined,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Initial ListView Animation',
    navigationScreen: InitialAnimatedListView(index: 25),
    icon: Icons.line_style,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Initial ListView Animation',
    navigationScreen: AnimatedImage(),
    icon: Icons.line_style,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Riverpod Guide',
    navigationScreen: RiverpodGuideHome(),
    icon: Icons.waves_rounded,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Flutter text to speech',
    navigationScreen: FlutterTextToSpeech(),
    icon: Icons.waves_rounded,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Flutter Amazing Brick',
    navigationScreen: AmazingBrick(),
    icon: Icons.tab_sharp,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Animation',
    navigationScreen: AnimationHome(),
    icon: Icons.animation_outlined,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Chain Animation',
    navigationScreen: ChainAnimation(),
    icon: Icons.animation_rounded,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: '3D Animation',
    navigationScreen: Animation3D(),
    icon: Icons.animation_rounded,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Hero Animation',
    navigationScreen: HeroAnimation(),
    icon: Icons.animation_rounded,
    // appImage: 'assets/images/card_bg.jpg',
  ),
];
