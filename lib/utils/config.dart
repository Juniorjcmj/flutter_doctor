
import 'package:flutter/material.dart';

class Config {
  static MediaQueryData? mediaqueryData;
  static double? screenWidth;
  static double? screenHeight;


  void int(BuildContext context){
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
}