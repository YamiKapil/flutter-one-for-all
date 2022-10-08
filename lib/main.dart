import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_for_all/habit_tracker/habit_home.dart';

import 'bubble_trouble/bubble_home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // open hive box
  await Hive.openBox('habit_database');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: BubbleHome(),
      home: HabitHome(),
      // control the default color of the app..
      theme: ThemeData(primarySwatch: Colors.grey),
    );
  }
}
