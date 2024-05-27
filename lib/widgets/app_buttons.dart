import 'package:flutter/material.dart';
import 'package:master_class_travel_app/misc/colors.dart';
import 'package:master_class_travel_app/widgets/app_text.dart';

class AppButtons extends StatelessWidget {
  final int index;
  final Color color;
  final Color backgroundColor;
  final double size ;
  final Color borderColor;
  final IconData? icon;

  AppButtons(this.index, this.color, this.backgroundColor, this.size, this.borderColor, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: size,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 1.0
        ),
          borderRadius: BorderRadius.circular(15),
          color:backgroundColor
      ),
      height: size,
      child: Center(
        child: icon==null?AppText(text: index.toString(),color: color,):Icon(icon,color:color,),
      ),
    );
  }
}
