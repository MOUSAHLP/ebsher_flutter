import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/widgets/custom_app_background.dart';
import 'package:flutter/material.dart';

class LoginScreenBackGround extends StatelessWidget {
  const LoginScreenBackGround({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CustomAppBackGround(
          child: SizedBox(),
        ),
        Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 320,
            ),
            Positioned(
              top: -5,
              right: -115,
              child: Container(
                width: 320,
                height: 320,
                decoration: const BoxDecoration(
                  color: ColorManager.softYellow,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: ColorManager.shadowGrey,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: -10,
              right: -120,
              child: Image.asset(
                ImageManager.signInAsset2,
                width: 320,
              ),
            ),
            Positioned(
              top: -165,
              left: -170,
              child: Container(
                width: 320,
                height: 320,
                decoration: const BoxDecoration(
                  color: ColorManager.softYellow,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: ColorManager.shadowGrey,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: -150,
              left: -170,
              child: Image.asset(
                ImageManager.signInAsset,
                width: 320,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
