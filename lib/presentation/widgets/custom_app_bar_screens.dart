import 'package:absher/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/app_router/app_router.dart';
import '../resources/assets_manager.dart';
import '../resources/style_app.dart';
import '../resources/values_app.dart';
import 'custom_icon.dart';

// ignore: must_be_immutable
class CustomAppBarScreens extends StatelessWidget {
  String title;

  CustomAppBarScreens({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.backgroundEndColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: PaddingApp.p16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                AppRouter.pop(context);
              },
              child: CustomIcon(
                svgAsset: IconsManager.iconBackArrow,
              ),
            ),
            Text(title, style: getBoldStyle(color: Colors.white, fontSize: 18)),
            // CustomIcon(
            //   svgAsset: IconsManager.iconShare,
            // ),
            SizedBox()
          ],
        ),
      ),
    );
  }
}
