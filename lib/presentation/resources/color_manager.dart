import 'package:flutter/material.dart';

class ColorManager {
  static const Color primaryColor = Color(0xff36ADB0);
  static const Color shimmerBaseColor = Color(0xffEEEEEE);
  static const Color shimmerHighlightColor = Color(0xffE0E0E0);
  static const Color backgroundStartColor = Color(0xFF3ABABD);
  static const Color backgroundEndColor = Color(0xFF257679);
//  static const Color backgroundEndColor = Color(0xFF1D5D5F);
  static Color circleStartColor = const Color(0xffA3FEC7).withOpacity(1);
  static Color circleEndColor = const Color(0xff6AC6FC).withOpacity(1);
  static const Color lightWhiteColor = const Color(0xffEDEDED);
  static const Color lightYellowColor = const Color(0xffF2D16A);
  static const Color lightBlueColor = const Color(0xff3ABABD);
  static const Color whiteColor = const Color(0xffffffff);
  static const Color softYellow = Color(0xFFF2D16A);
  static const Color shadowGrey = Color(0xFF707070);
  static const List<BoxShadow> boxShadow=[
    BoxShadow(
      color: Colors.black45,
      blurRadius: 4.0, // soften the shadow
      spreadRadius: 1.0, //extend the shadow
      offset: Offset(
        1.0, // Move to right 5  horizontally
        1.0, // Move to bottom 5 Vertically
      ),
    )
  ];
}
