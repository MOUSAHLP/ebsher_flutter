import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/widgets/custom_app_background.dart';

import 'package:flutter/material.dart';

class ForgetPasswordScreenBackground extends StatelessWidget {
  const ForgetPasswordScreenBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomAppBackGround(
          child: SizedBox(),
        ),
        Stack(
          children: [
            Positioned(
              top: -65,
              left: -55,
              child: Container(
                width: 340,
                height: 340,
                decoration: const BoxDecoration(
                  color: ColorManager.softYellow,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      color: ColorManager.shadowGrey,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: -60,
              left: -60,
              child: Image.asset(
                ImageManager.resetPasswordAsset3,
                width: 340,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
