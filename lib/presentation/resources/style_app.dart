

import 'font_app.dart';
import 'package:flutter/material.dart';
TextStyle? _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: FontConstant.fontFamily,
      color: color,
      fontWeight: fontWeight);
}
// regular style
TextStyle? getRegularStyle(
    {double fontSize = FontSizeApp.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightApp.regular, color);
}

// Medium style
TextStyle? getMediumStyle(
    {double fontSize = FontSizeApp.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightApp.medium, color);
}
// light style
TextStyle? getLightStyle(
    {double fontSize = FontSizeApp.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightApp.light, color);
}

// semi bold style
TextStyle? getSemiBoldStyle(
    {double fontSize = FontSizeApp.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightApp.semiBold, color);
}

// bold style
TextStyle? getBoldStyle(
    {double fontSize = FontSizeApp.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightApp.bold, color);
}