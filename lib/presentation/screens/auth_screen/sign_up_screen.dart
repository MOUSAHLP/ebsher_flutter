import 'package:absher/core/font_app.dart';
import 'package:absher/core/style_app.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/widgets/custom_input_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../widgets/custom_app_background.dart';
import '../../widgets/custom_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const SignUpBackGroundDecoration(),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 240,
                ),
                Text(
                  'أنشاء حساب',
                  style: getBoldStyle(
                    color: Colors.white,
                    fontSize: FontSizeApp.s36,
                  ),
                ),
                Text(
                  'أضف التفاصيل الخاصة بك لتسجيل حساب',
                  style: getBoldStyle(
                    color: Colors.white,
                    fontSize: FontSizeApp.s14,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const CustomInputField(
                  hintText: 'الاسم بالكامل',
                  withLabel: true,
                  icon: Icons.person,
                ),
                const SizedBox(
                  height: 8,
                ),
                const CustomInputField(
                  hintText: 'أضف رقمك',
                  withLabel: true,
                  icon: Icons.phone_android,
                ),
                const SizedBox(
                  height: 8,
                ),
                const CustomInputField(
                  hintText: '00 - 00 - 0000',
                  withLabel: true,
                  icon: Icons.date_range,
                ),
                const SizedBox(
                  height: 8,
                ),
                const CustomInputField(
                  hintText: 'جنس',
                  withLabel: true,
                  icon: Icons.person,
                ),
                const SizedBox(
                  height: 8,
                ),
                const CustomInputField(
                  hintText: 'كلمة المرور',
                  withLabel: true,
                  icon: Icons.lock_open_rounded,
                ),
                const SizedBox(
                  height: 16,
                ),
                const CustomButton(label: 'تسجيل'),
                const SizedBox(
                  height: 8,
                ),
                RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'هل لديك حساب؟',
                        style: getBoldStyle(
                          color: Colors.white,
                          fontSize: FontSizeApp.s14,
                        ),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: 'تسجيل الدخول',
                        style: getBoldStyle(
                          color: ColorManager.softYellow,
                          fontSize: FontSizeApp.s14,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => print('Tap Here onTap'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

class SignUpBackGroundDecoration extends StatelessWidget {
  const SignUpBackGroundDecoration({Key? key}) : super(key: key);

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
              top: -30,
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
              top: -40,
              left: -60,
              child: Image.asset(
                ImageManager.signUpAsset,
                width: 280,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
