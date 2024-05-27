import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_class_travel_app/cubit/app_cubit_states.dart';
import 'package:master_class_travel_app/cubit/app_cubits.dart';
import 'package:master_class_travel_app/misc/colors.dart';
import 'package:master_class_travel_app/widgets/app_buttons.dart';
import 'package:master_class_travel_app/widgets/app_large_taxt.dart';
import 'package:master_class_travel_app/widgets/app_text.dart';
import 'package:master_class_travel_app/widgets/responsive_button.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int gottenStars = 3 ;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits,CubitStates>(
        builder: (context,state){
          DetailState detail = state as DetailState;
      return Scaffold(
          body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Stack(
              children: [
                Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 350,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage('http://mark.bslmeiyu.com/uploads/'+detail.place.img),
                              fit: BoxFit.cover)),
                    )),
                Positioned(
                    left: 20,
                    top: 50,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<AppCubits>(context).goHome();
                            },
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                            )),
                      ],
                    )),
                Positioned(
                  top: 200,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    width: MediaQuery.of(context).size.width,
                    height: 500,
                    padding: EdgeInsets.only(left: 20,right: 20,top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppLargeText(text: detail.place.name,color: Colors.black54.withOpacity(0.8),),
                            AppLargeText(text: "\$ "+detail.place.price.toString(),color: AppColors.mainColor,),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Icon(Icons.location_on,color: AppColors.mainColor,),
                            SizedBox(width: 10,),
                            AppText(text: detail.place.location,color: AppColors.mainTextColor,)
                          ],
                        ),
                        SizedBox(height:15,),
                        Row(
                          children: [
                            Wrap(
                                children: List.generate(5, (index) {
                                  return Icon(Icons.star,color:detail.place.stars > index ? AppColors.starColor:AppColors.textColor2,);
                                })
                            ),
                            SizedBox(width: 10,),
                            AppText(text: "(5.0)",color:AppColors.textColor2)
                          ],
                        ),
                        SizedBox(height:15,),
                        AppLargeText(text: 'People',color: Colors.black54.withOpacity(0.8),size: 20,),
                        SizedBox(height: 5,),
                        AppText(text: 'Number Of People in your group'),
                        SizedBox(height: 10,),
                        Wrap(
                          children: List.generate(5, (index){
                            return InkWell(onTap: (){
                              setState(() {
                                selectedIndex = index;
                              });
                            },child: AppButtons(index+1,selectedIndex==index?Colors.white:Colors.black,selectedIndex==index?Colors.black:AppColors.buttonBackground,50,AppColors.buttonBackground,null));
                          }),

                        ),
                        SizedBox(height: 10,),
                        AppLargeText(text: 'Description',size: 20,),
                        SizedBox(height: 5,),
                        AppText(text:detail.place.desc),
                        SizedBox(height: 20,),



                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 40,
                    left: 20,
                    right: 20,
                    child: Row(
                      children: [
                        AppButtons(0, AppColors.textColor2, Colors.white, 60, AppColors.textColor2, Icons.favorite_border),
                        Flexible(child: ResponsiveButton(isResponsive: true,)),
                      ],
                    ))
              ],
            ),
          ));
    });
  }
}
