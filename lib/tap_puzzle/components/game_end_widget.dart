import 'package:flutter/material.dart';

class GameEndWidget extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onPlayTap;
  const GameEndWidget({super.key, this.onMenuTap, this.onPlayTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              height: MediaQuery.of(context).size.height * 0.12,
              child: FittedBox(
                child: GestureDetector(
                  onTap: onMenuTap,
                  child: const Icon(
                    Icons.menu,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              height: MediaQuery.of(context).size.height * 0.12,
              child: FittedBox(
                child: GestureDetector(
                  onTap: onPlayTap,
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
