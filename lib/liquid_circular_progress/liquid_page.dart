import 'package:flutter/material.dart';
import 'package:one_for_all/liquid_circular_progress/liquid_circular_progress.dart';

class LiquidCircularProgressIndicatorPage extends StatelessWidget {
  const LiquidCircularProgressIndicatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liquid Circular Progress Indicators"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _AnimatedLiquidCircularProgressIndicator(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: <Widget>[
          //     SizedBox(
          //       width: 75,
          //       height: 75,
          //       child: LiquidCircularProgressIndicator(
          //         backgroundColor: Colors.black,
          //         valueColor: AlwaysStoppedAnimation(Colors.red),
          //       ),
          //     ),
          //     SizedBox(
          //       width: 75,
          //       height: 75,
          //       child: LiquidCircularProgressIndicator(
          //         backgroundColor: Colors.white,
          //         valueColor: AlwaysStoppedAnimation(Colors.pink),
          //         borderColor: Colors.red,
          //         borderWidth: 5.0,
          //         direction: Axis.horizontal,
          //       ),
          //     ),
          //     SizedBox(
          //       width: 75,
          //       height: 75,
          //       child: LiquidCircularProgressIndicator(
          //         backgroundColor: Colors.white,
          //         valueColor: AlwaysStoppedAnimation(Colors.grey),
          //         borderColor: Colors.blue,
          //         borderWidth: 5.0,
          //         center: Text(
          //           "Loading...",
          //           style: TextStyle(
          //             fontSize: 12.0,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ),
          //     ),
          //     SizedBox(
          //       width: 75,
          //       height: 75,
          //       child: LiquidCircularProgressIndicator(
          //         backgroundColor: Colors.lightGreen,
          //         valueColor: AlwaysStoppedAnimation(Colors.blueGrey),
          //         direction: Axis.horizontal,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class _AnimatedLiquidCircularProgressIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _AnimatedLiquidCircularProgressIndicatorState();
}

class _AnimatedLiquidCircularProgressIndicatorState
    extends State<_AnimatedLiquidCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = _animationController.value * 100;
    return Center(
      child: SizedBox(
        width: 150.0,
        height: 150.0,
        child: LiquidCircularProgressIndicator(
          value: _animationController.value,
          backgroundColor: Colors.white,
          valueColor: const AlwaysStoppedAnimation(Colors.blue),
          center: Text(
            "${percentage.toStringAsFixed(0)}%",
            style: const TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
