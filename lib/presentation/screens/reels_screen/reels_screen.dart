import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class ReelsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(child:
        Lottie.asset(IconsManager.iconSoon),),);
  }
}
