import '../resources/values_app.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  const EdgeInsets.symmetric(horizontal: PaddingApp.p22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
              IconsManager.iconNotification
          ),
          SvgPicture.asset(
              IconsManager.iconAppAbsher
          ),
          SvgPicture.asset(
              IconsManager.iconMenu
          ),
        ],
      ),
    );
  }
}
