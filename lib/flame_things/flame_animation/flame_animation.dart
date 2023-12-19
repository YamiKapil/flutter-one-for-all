// import 'package:flame/game.dart';
// import 'package:flutter/material.dart';
// import 'package:one_for_all/flame_things/flame_animation/sprite_sheet_widget.dart';

// class FlutterAnimation extends StatelessWidget {
//   const FlutterAnimation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 12,
//       height: 12,
//       child: Align(
//         alignment: Alignment.topCenter,
//         child: GameWidget(
//           game: SpriteSheetWidget(),
//         ),
//       ),
//     );
//   }
// }

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:one_for_all/flame_things/flame_animation/action_button.dart';
import 'package:one_for_all/flame_things/flame_animation/rain_partical.dart';
import 'package:one_for_all/flame_things/flame_animation/sprite_sheet_widget.dart';

class FlameAnimationWidget extends StatefulWidget {
  const FlameAnimationWidget({super.key, required this.title});
  final String title;

  @override
  State<FlameAnimationWidget> createState() => _FlameAnimationWidgetState();
}

class _FlameAnimationWidgetState extends State<FlameAnimationWidget> {
  double maxWidth = 0.0;
  double maxHeight = 0.0;
  late RainEffect game;

  @override
  void initState() {
    super.initState();
    game = RainEffect();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.of(context).size;
    final height = AppBar().preferredSize.height;
    maxWidth = size.width;
    maxHeight = size.height - height;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: GameWidget<RainEffect>(game: game, overlayBuilderMap: {
                'userArea': (ctx, game) {
                  return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Username')),
                            TextField(
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Password'))
                          ]));
                },
                'container1': (ctx, game) {
                  return ActionButtonWidget(
                      Colors.blueAccent, "Sign in", Alignment.bottomCenter, () {
                    print(
                        "=== This is Flutter widget inside Flutter Flame ===");
                  });
                },
              }, initialActiveOverlays: const [
                'userArea',
                'container1'
              ])),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent.shade400),
                      color: Colors.white,
                    ),
                    height: 200,
                  ),
                  ActionButtonWidget(
                      Colors.redAccent, "Sign out", Alignment.bottomCenter, () {
                    print("=== This is normal Flutter widget ===");
                  })
                ],
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        width: 1,
        height: 1,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GameWidget(
            game: SpriteSheetWidget(),
          ),
        ),
      ),
    ]);
  }
}
