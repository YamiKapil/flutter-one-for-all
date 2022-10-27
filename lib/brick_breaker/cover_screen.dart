import 'package:flutter/material.dart';
import 'package:one_for_all/common_components/animated_color_text.dart';

class CoverScreen extends StatelessWidget {
  final bool hasGameStarted;
  const CoverScreen({super.key, required this.hasGameStarted});

  @override
  Widget build(BuildContext context) {
    return (hasGameStarted)
        ? Container()
        : Container(
            alignment: const Alignment(0, -0.2),
            child: Text(
              'Tap to play',
              style: TextStyle(
                color: Colors.deepPurple[400],
              ),
            ),
          );
  }
}
