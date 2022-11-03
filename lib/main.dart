import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_for_all/common_components/my_behaviour.dart';
import 'package:one_for_all/tap_puzzle/screens/player_selection_screen.dart';
import 'package:one_for_all/tap_puzzle/screens/tap_puzzle_splash.dart';

import 'my_homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // open hive box
  await Hive.openBox('habit_database');
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScrollConfiguration(
        behavior: MyBehavior(),
        child: const MyHomePage(),
        // child: const BrickBreakerHome(),
        // child: const TapPuzzleSplash(),
      ),
      // control the default color of the app..
      // theme: ThemeData(primarySwatch: Colors.purple),
    );
  }
}
