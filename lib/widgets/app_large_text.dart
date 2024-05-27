import 'package:flutter/material.dart';

class AppLargeText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  AppLargeText({required this.text, this.color = Colors.black, this.size = 30});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize:size ,color: color,fontWeight: FontWeight.bold));
  }
}
