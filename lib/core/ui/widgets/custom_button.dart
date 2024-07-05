import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? sideColor;
  final double paddingHorizontal;
  final double paddingVertical;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.sideColor,
    this.paddingHorizontal = 0,
    this.paddingVertical = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          backgroundColor: backgroundColor,
          side: BorderSide(color: sideColor ?? Colors.transparent),
        ),
        onPressed: onPressed,
        child: Text(text.toUpperCase()),
      ),
    );
  }
}
