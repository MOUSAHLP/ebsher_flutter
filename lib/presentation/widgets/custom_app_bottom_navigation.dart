import '../resources/values_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
class CustomAppBottomNavigation extends StatelessWidget {
  const CustomAppBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: SizeApp.s50,
      decoration: const BoxDecoration(
        color: ColorManager.lightWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(RadiusApp.r20),
          topRight: Radius.circular(RadiusApp.r20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            IconsManager.iconStars,
          ),
          SvgPicture.asset(
            IconsManager.iconSearch,
          ),
          const SizedBox(width: SizeApp.s5),
          SvgPicture.asset(
            IconsManager.iconVideo,
          ),
          SvgPicture.asset(
            IconsManager.iconUser,
          ),
        ],
      ),
    );
  }
}
