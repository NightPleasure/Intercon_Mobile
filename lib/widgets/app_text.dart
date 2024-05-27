import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final String fontFamily; // Add this line

  // Include fontFamily in your constructor and provide a default value if desired
  AppText({
    required this.text,
    this.color = Colors.black54,
    this.size = 16,
    this.fontFamily = 'Rubik', // Default font family, optional
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontFamily: fontFamily, // Apply the fontFamily
      ),
    );
  }
}
