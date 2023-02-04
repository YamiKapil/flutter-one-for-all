import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key,
      this.icon,
      this.text,
      this.textColor,
      this.containerColor,
      this.iconColor,
      this.onPress});
  final IconData? icon;
  final String? text;
  final Color? textColor;
  final Color? containerColor;
  final Color? iconColor;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: (icon != null)
          ? InkWell(
              onTap: onPress,
              child: Icon(
                icon,
                size: 35,
                color: iconColor,
              ),
            )
          : InkWell(
              onTap: onPress,
              child: Text(
                text!,
                style: TextStyle(
                  fontSize: 20,
                  color: textColor,
                ),
              ),
            ),
    );
  }
}
