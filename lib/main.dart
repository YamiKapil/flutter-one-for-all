import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_for_all/common_components/my_behaviour.dart';

import 'my_homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // open hive box
  await Hive.openBox('habit_database');
  // Socket socket = io(
  //     'http://192.168.13.79:8080/',
  //     OptionBuilder()
  //         .setTransports(['websocket']) // for Flutter or Dart VM
  //         .disableAutoConnect()
  //         .setQuery({
  //           'token':
  //               'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI0NjIiLCJtb2JpbGVOdW1iZXIiOiI5ODQ5MjIzMzQ0IiwicGVybWlzc2lvbnMiOltdLCJyb2xlcyI6WyJTRUVLRVIiXSwiZnVsbE5hbWUiOm51bGwsImV4cCI6MTY3MTYzMjk3MywidXNlcklkIjo0NjIsImlhdCI6MTY3MTYxNDk3MywiZW1haWwiOiJoYXJpLmtyaXNobmFAeW9wbWFpbC5jb20iLCJ1c2VybmFtZSI6Ijk4NDkyMjMzNDQifQ.KqiVsKUTsS24srlfPz5AYLdRRzLgemc8wumoDP-OWAvol4PlnNaosiv_6D-KFnzHn06XEWh6IWTg-Svww6aR1w'
  //         }) // disable auto-connection
  //         // .setExtraHeaders({'foo': 'bar'}) // optional
  //         .build());
  // socket.connect();
  // socket.onConnect((_) {
  //   log('connect');
  //   socket.emitWithAck('msg', 'init', ack: (data) {
  //     log('ack $data');
  //     if (data != null) {
  //       log('from server $data');
  //     } else {
  //       log("Null");
  //     }
  //   });
  // });
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
      ),
      // control the default color of the app..
      // theme: ThemeData(primarySwatch: Colors.purple),
    );
  }
}
