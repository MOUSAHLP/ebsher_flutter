import 'package:absher/core/colors_app.dart';
import 'package:absher/core/style_app.dart';
import 'package:flutter/material.dart';


ThemeData getThemeApp() {
  return ThemeData(

    /// main color
//   primaryColor:
//   primaryColorLight:
//   primaryColorDark:
//   disabledColor:

    ///cardview theme
//   cardTheme: CardTheme()
    ///app bar theme
//appBarTheme: AppBarTheme()
    ///button theme
// buttonTheme: ButtonThemeData(
//  shape:const StadiumBorder(),
//  disabledColor: ,
//  buttonColor: ,
//  splashColor: ,
//)

    ///eleveted button
//    elevatedButtonTheme: ElevatedButtonThemeData(
//      style: ElevatedButton.styleFrom(
//        textStyle: ,
//        primary: ,
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(SizeApp.s12)
//        )
//      )
//    )
    ///text theme
    textTheme: TextTheme(
//titleLarge: ,
      titleMedium: getBoldStyle(color: ColorsApp.white,fontSize: 12)
    )

    ///input decoration theme(text form field)
//inputDecorationTheme: const InputDecorationTheme(
//  contentPadding:
//hintStyle:
//labelStyle:
//errorStyle:
//enabledBorder: OutlineInputBorder(),
//focusedBorder: OutlineInputBorder(
//)
//errorBorder: OutlineInputBorder()
//focusedErrorBorder: OutlineInputBorder()
//)
  );
}