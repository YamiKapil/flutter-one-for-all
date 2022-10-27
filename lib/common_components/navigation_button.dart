import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationButton extends StatefulWidget {
  final String screenName;
  final Widget navigationScreen;
  final String? appImage;
  final IconData? icon;
  final MaterialColor? appColor;
  const NavigationButton({
    super.key,
    required this.screenName,
    required this.navigationScreen,
    this.appImage,
    this.icon,
    this.appColor,
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
      child: InkWell(
        //  overlayColor: MaterialStateProperty.all(Colors.red),
        onTap: () async {
          await _animationController.forward(from: 0.0);
          if (!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MaterialApp(
                debugShowCheckedModeBanner: false,
                home: widget.navigationScreen,
                theme: ThemeData(
                  primarySwatch: widget.appColor ?? Colors.purple,
                  fontFamily: GoogleFonts.audiowide().fontFamily,
                ),
                
              ),
            ),
          );
        },
        child: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(8),
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(height: 10),
                Flexible(
                  child: (widget.appImage != null)
                      ? Image.asset(
                          widget.appImage!,
                          fit: BoxFit.contain,
                        )
                      : Icon(widget.icon),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: Text(
                    widget.screenName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
