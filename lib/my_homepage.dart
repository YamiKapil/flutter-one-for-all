import 'package:flutter/material.dart';
import 'package:one_for_all/bubble_trouble/bubble_home.dart';
import 'package:one_for_all/common_components/navigation_button.dart';
import 'package:one_for_all/habit_tracker/habit_home.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              NavigationButton(
                  screenName: 'Bubble Trouble', navigationScreen: BubbleHome()),
              NavigationButton(
                  screenName: 'Habit Tracker', navigationScreen: HabitHome()),
            ],
          ),
        ),
      ),
    );
  }
}
