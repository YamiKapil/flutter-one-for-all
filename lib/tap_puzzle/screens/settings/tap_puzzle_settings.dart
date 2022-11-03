import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:one_for_all/tap_puzzle/data/constants.dart';

class TapPuzzleSettings extends StatelessWidget {
  final VoidCallback onBackPressed;
  final AudioPlayer player;
  const TapPuzzleSettings({
    super.key,
    required this.onBackPressed,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SwitchListTile.adaptive(
          //   dense: true,
          //   value: false,
          //   onChanged: (value) {},
          //   title: const Text(
          //     'Bg Music',
          //     style: TextStyle(
          //       fontSize: 20,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),

          ListTile(
            dense: true,
            leading: const Text(
              'Game Mode',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            trailing: TextButton(
              onPressed: () {},
              child: Text(
                'Easy',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              player.play(AssetSource(clickSound));
              onBackPressed();
            },
            child: const Text(
              'Back',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
