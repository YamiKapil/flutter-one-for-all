import 'package:flutter/cupertino.dart';

import '../bubble_trouble/bubble_home.dart';
import '../habit_tracker/habit_home.dart';
import 'navigation_button.dart';

List<Widget> listOfScreens = const [
  NavigationButton(
    screenName: 'Bubble Trouble',
    navigationScreen: BubbleHome(),
  ),
  NavigationButton(
    screenName: 'Habit Tracker',
    navigationScreen: HabitHome(),
  ),
];
