import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String screenName;
  final Widget navigationScreen;
  const NavigationButton({
    super.key,
    required this.screenName,
    required this.navigationScreen,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => navigationScreen,
          ),
        );
      },
      child: Text(screenName),
    );
  }
}
