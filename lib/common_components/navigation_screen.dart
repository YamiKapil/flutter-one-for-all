import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_for_all/battery_level/battery_level.dart';
import 'package:one_for_all/responsive_row/responsive_row.dart';
import 'package:one_for_all/tap_puzzle/screens/player_selection_screen.dart';
import 'package:one_for_all/tap_puzzle/screens/tap_puzzle_game_screen.dart';
import 'package:one_for_all/tap_puzzle/screens/tap_puzzle_splash.dart';

import '../animated_listview_builder/animate_image.dart';
import '../animated_listview_builder/animated_listview_builder.dart';
import '../animated_listview_builder/initial_animated_listview.dart';
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
];
