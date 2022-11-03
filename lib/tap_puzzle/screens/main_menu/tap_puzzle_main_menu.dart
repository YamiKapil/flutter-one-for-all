import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:one_for_all/main.dart';
import 'package:one_for_all/my_homepage.dart';
import 'package:one_for_all/tap_puzzle/data/constants.dart';

import '../../components/menu_items.dart';
import '../player_selection_screen.dart';

class TapPuzzleMainMenu extends StatelessWidget {
  final VoidCallback onSettingsPressed;
  final AudioPlayer player;
  const TapPuzzleMainMenu({
    Key? key,
    required this.onSettingsPressed,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MenuItems(
            icon: Icons.play_arrow_rounded,
            text: 'Play',
            function: () {
              player.play(AssetSource(clickSound));
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PlayerSelectionScreen(),
                ),
              );
            },
          ),
          MenuItems(
            icon: Icons.settings,
            text: 'Settings',
            // function: () => Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => const TapPuzzleSettings(),
            //   ),
            // ),
            function: () {
              player.play(AssetSource(clickSound));
              onSettingsPressed();
            },
          ),
          MenuItems(
            icon: Icons.info_outline_rounded,
            text: 'Info',
            function: () {
              player.play(AssetSource(clickSound));
            },
          ),
          MenuItems(
            icon: Icons.logout_outlined,
            text: 'Exit',
            function: () {
              player.play(AssetSource(clickSound));
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
