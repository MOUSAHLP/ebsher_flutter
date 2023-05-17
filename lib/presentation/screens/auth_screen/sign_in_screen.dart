import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/widgets/custom_input_field.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../widgets/custom_app_background.dart';
import '../../widgets/custom_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        CustomAppBackGround(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomInputField(
                  hintText: 'أضف رقمك',
                  withLabel: true,
                  icon: Icons.phone_android,
                ),
                SizedBox(
                  height: 8,
                ),
                CustomInputField(
                  hintText: AppLocalizations.of(context)!.password,
                  withLabel: true,
                  icon: Icons.lock_open_rounded,
                ),
                SizedBox(
                  height: 8,
                ),
                CustomButton(label: 'تسجيل '),
              ],
            ),
          ),
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
    ));
  }
}
