import 'package:absher/core/app_router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/style_app.dart';
import '../screens/auth_screen/sign_in_screen.dart';
class CustomGuest extends StatelessWidget {
  const CustomGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return   Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(IconsManager.iconLogIn,),
        MaterialButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(20.0))),
          color: ColorManager.softYellow,
          onPressed: (){
            AppRouter.push(context, const SignInConfirmationScreen());

          },child: Text("تسجيل دخول" , style: getBoldStyle(color: Colors.white),),)
      ],
    );
  }
}
