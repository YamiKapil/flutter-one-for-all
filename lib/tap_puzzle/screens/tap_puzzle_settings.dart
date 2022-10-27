import 'package:flutter/material.dart';

class TapPuzzleSettings extends StatelessWidget {
  final VoidCallback onBackPressed;
  const TapPuzzleSettings({
    super.key,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SwitchListTile.adaptive(
            value: false,
            onChanged: (value) {},
            title:const  Text(
              'Bg Music',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            // tileColor: Theme.of(context).backgroundColor,
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: onBackPressed,
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
