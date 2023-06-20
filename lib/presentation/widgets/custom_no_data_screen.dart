import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../resources/assets_manager.dart';

class CustomNoDataScreen extends StatelessWidget {
  const CustomNoDataScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(IconsManager.iconNoResult),
        Text(AppLocalizations.of(context)!.noItem,style: getBoldStyle(color: Colors.white),)
      ],
    ));
  }
}
