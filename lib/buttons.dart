import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback? buttonTapped;
  final Color? textColor;
  final Color? color;

  const MyButton({
    super.key,
    required this.text,
    this.buttonTapped,
    this.textColor,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Container(
        margin: const EdgeInsets.all(8.0), // Increased margin size for better spacing
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color ?? Colors.blue, // Provide a default value for color
        ),
        child: Container(
          alignment: Alignment.center, // Center-align the text
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: textColor ?? Colors.white, // Provide a default value for textColor
            ),
          ),
        ),
      ),
    );
  }
}