import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final IconData icon;
  final VoidCallback? function;
  const Buttons({super.key, required this.icon, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 50,
          height: 50,
          color: Colors.grey.shade100,
          child: Center(
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}
