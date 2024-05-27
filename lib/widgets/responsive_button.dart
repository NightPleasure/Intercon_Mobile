import 'package:flutter/material.dart';
import 'package:master_class_travel_app/misc/colors.dart';
import 'package:master_class_travel_app/widgets/app_text.dart';

class ResponsiveButton extends StatelessWidget {
  bool? isResponsive ;
  double? width;

  ResponsiveButton({this.isResponsive =false ,this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.mainColor
      ),
      child: Row(
        mainAxisAlignment: (isResponsive??false)?MainAxisAlignment.spaceAround:MainAxisAlignment.center,
        children: [
          (isResponsive??false)?AppText(text: 'Book Trip Now',color: Colors.white,):Container(),
          Image.asset('img/button-one.png',fit: BoxFit.cover,),

        ],
      ),
    );
  }
}


