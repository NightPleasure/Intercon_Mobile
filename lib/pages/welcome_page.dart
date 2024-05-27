import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_class_travel_app/cubit/app_cubits.dart';
import 'package:master_class_travel_app/misc/colors.dart';
import 'package:master_class_travel_app/widgets/app_large_taxt.dart';
import 'package:master_class_travel_app/widgets/app_text.dart';
import 'package:master_class_travel_app/widgets/responsive_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images = [
    'img/welcome-one.png',
    "img/welcome-two.png",
    'img/welcome-three.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (_,index){

            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(images[index])
                  )
              ),
              child: Container(
                margin: EdgeInsets.only(top: 100,left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(
                          text: "Review",
                          color: Colors.white,
                        ),
                        AppText(
                            text: "BUSINESSES" ,
                            size: 30,
                          color: Colors.black,
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: 350,
                          child: AppText(
                            text: "Descoperă, evaluează și \nîmpărtășește-ți experiența",
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        SizedBox(height: 60,),
                        GestureDetector(onTap: (){BlocProvider.of<AppCubits>(context).getData();},child: ResponsiveButton(width: 100,)),
                      ],
                    ),
                    Column(
                      children: List.generate(3, (indexDots) => Container(
                        margin: EdgeInsets.only(bottom: 2),
                        width: 8,
                        height:index==indexDots?25:8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: index==indexDots?AppColors.mainColor:AppColors.mainColor.withOpacity(0.3)
                        ),
                      )),
                    )
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}