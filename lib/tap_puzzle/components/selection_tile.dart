import 'package:flutter/material.dart';

class SelectionTile extends StatelessWidget {
  final String playerNumber;
  final Color tileColor;
  final VoidCallback? onTap;
  const SelectionTile({
    super.key,
    required this.playerNumber,
    required this.tileColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            color: tileColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: FittedBox(
            child: Text(
              playerNumber,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
