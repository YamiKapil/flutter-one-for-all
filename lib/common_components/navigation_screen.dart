import 'package:flutter/cupertino.dart';
import 'package:one_for_all/responsive_row/responsive_row.dart';

import '../bubble_trouble/bubble_home.dart';
import '../habit_tracker/habit_home.dart';
import 'navigation_button.dart';

List<Widget> listOfScreens = const [
  NavigationButton(
    screenName: 'Bubble Trouble',
    navigationScreen: BubbleHome(),
    appImage: 'assets/gifs/itachi.gif',
  ),
  NavigationButton(
    screenName: 'Habit Tracker',
    navigationScreen: HabitHome(),
    appImage: 'assets/images/habit_tracker.png',
  ),
  NavigationButton(
    screenName: 'Responsive Row',
    navigationScreen: ResponsiveRow(),
    appImage: 'assets/images/habit_tracker.png',
  ),
];
