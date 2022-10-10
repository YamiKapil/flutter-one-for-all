import 'dart:math';

import 'package:flutter/material.dart';

class NavigationButton extends StatefulWidget {
  final String screenName;
  final Widget navigationScreen;
  const NavigationButton({
    super.key,
    required this.screenName,
    required this.navigationScreen,
  });

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(360 * _animationController.value * (pi / 180.0)),
        child: child,
      ),
      child: ElevatedButton(
        onPressed: () async {
          await _animationController.forward(from: 0.0);
          if (!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => widget.navigationScreen,
            ),
          );
        },
        child: Text(widget.screenName),
      ),
    );
  }
}
