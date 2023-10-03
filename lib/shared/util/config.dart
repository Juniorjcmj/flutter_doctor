
import 'package:flutter/material.dart';

class Config {
  static MediaQueryData? mediaqueryData;
  static double? screenWidth;
  static double? screenHeight;
  static String? apiUrl = 'https://api-sec-virtual-production.up.railway.app';


  void init(BuildContext context){
    mediaqueryData = MediaQuery.of(context);
    screenWidth = mediaqueryData?.size.width;
    screenHeight = mediaqueryData?.size.height;    
  }

  static get widtSize{
    return screenWidth;
  }
  static get height{
    return screenHeight;
  }
 

  static const spaceSmall = SizedBox(height: 25,);
  static final spaceMedium = SizedBox(height: screenHeight! * 0.05,);
  static final spaceBig = SizedBox(height: screenHeight! * 0.08,);



  //textForm field border
  static const outlineBorder = OutlineInputBorder(
         borderRadius: BorderRadius.all(Radius.circular(8))
  );

  static const fucusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Colors.greenAccent
      )

  );

   static const errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Colors.red
      )

  );

 // static const primaryColor = Colors.greenAccent;
  static const primaryColor = Colors.teal;
  static const secundColor = Colors.grey;
  static const terciaryColor = Colors.amber;
}