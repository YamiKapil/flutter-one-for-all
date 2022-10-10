import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('One For All'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
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
