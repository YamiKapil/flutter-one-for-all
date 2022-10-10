import 'package:flutter/material.dart';
import 'package:one_for_all/bubble_trouble/bubble_home.dart';
import 'package:one_for_all/common_components/navigation_button.dart';
import 'package:one_for_all/habit_tracker/habit_home.dart';

import 'common_components/navigation_screens.dart';

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
            children: listOfScreens,
          ),
        ),
      ),
    );
  }
}
