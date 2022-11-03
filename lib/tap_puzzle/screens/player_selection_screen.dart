import 'package:flutter/material.dart';
import 'package:one_for_all/tap_puzzle/components/selection_tile.dart';
import 'package:one_for_all/tap_puzzle/screens/tap_puzzle_game_screen.dart';

class PlayerSelectionScreen extends StatelessWidget {
  const PlayerSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/bg.jpg'),
          ),
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectionTile(
              playerNumber: '2P',
              tileColor: Colors.red,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TapPuzzleGameScreen(players: 2),
                ),
              ),
            ),
            SelectionTile(
              playerNumber: '3P',
              tileColor: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TapPuzzleGameScreen(players: 3),
                  ),
                );
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Text('Coming Soon'),
                //   ),
                // );
              },
            ),
            SelectionTile(
              playerNumber: '4P',
              tileColor: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TapPuzzleGameScreen(players: 4),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
