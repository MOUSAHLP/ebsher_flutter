import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/widgets/custom_app_background.dart';

import 'package:flutter/material.dart';


class OtpScreenBackground extends StatelessWidget {
  const OtpScreenBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CustomAppBackGround(
          child: SizedBox(),
        ),
        Stack(
          children: [
            Positioned(
              top: -50,
              right: -60,
              child: Container(
                width: 280,
                height: 280,
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
              top: -70,
              right: -50,
              child: Image.asset(
                ImageManager.otpAsset,
                width: 280,
              ),
            ),
            Positioned(
              top: -60,
              left: -55,
              child: Container(
                width: 280,
                height: 280,
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
              top: -80,
              left: -60,
              child: Image.asset(
                ImageManager.otpAsset2,
                width: 280,
              ),
            ),
          ],
        ),
      ],
    );
  }
}