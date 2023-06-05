import 'dart:ui';

import 'package:absher/bloc/authentication_bloc/authertication_bloc.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/values_app.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../bloc/bottom_bloc/bottom_bloc.dart';
import '../../bloc/bottom_bloc/bottom_event.dart';
import '../../core/services/services_locator.dart';
import '../resources/color_manager.dart';
import '../resources/style_app.dart';
import '../screens/favorites_screen/favorites_screen.dart';
import 'dialogs/logout_confirmation_dialog.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0), //this is dependent on the import statment above
            child: Container(
                decoration: BoxDecoration(color: Colors.transparent))),
        Padding(
          padding: const EdgeInsets.only(
            top: 40,
            bottom: 100,
          ),
          child: ClipRRect(
            borderRadius:
                const BorderRadiusDirectional.only(topEnd: Radius.circular(50)),
            child: Drawer(
              width: 250,
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 250,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              opacity: 0.1,
                              image: AssetImage(ImageManager.profile),
                              fit: BoxFit.cover,
                            ),
                            color: ColorManager.softYellow,
                            borderRadius: BorderRadiusDirectional.only(
                                bottomStart: Radius.circular(50)),
                          ),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(RadiusApp.r50),
                                      child: Image.asset(
                                        ImageManager.test,
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      context
                                          .read<AuthenticationBloc>()
                                          .loginResponse!
                                          .name,
                                      style: getBoldStyle(
                                          color: Colors.white, fontSize: 23),
                                    ),
                                    Text(
                                        "+963 - ${context.read<AuthenticationBloc>().loginResponse!.phone}",
                                        textDirection: TextDirection.ltr,
                                        style: getLightStyle(
                                            color: Colors.white, fontSize: 17)),
                                  ],
                                ),
                              ]),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        buildElevatedButton(
                            AppLocalizations.of(context)!.profile,
                            IconsManager.iconUserSetting,
                            () {}),
                        buildElevatedButton(
                            AppLocalizations.of(context)!.favorite,
                            IconsManager.iconStar,
                            () {
                              sl<BottomBloc>().add(NewBottomChange(1));
                              AppRouter.pop(context);
                            }),
                        buildElevatedButton(
                            AppLocalizations.of(context)!.language,
                            IconsManager.iconWorld,
                            () {}),
                        buildElevatedButton(AppLocalizations.of(context)!.about,
                            IconsManager.iconAbout, () {}),
                        buildElevatedButton(
                            AppLocalizations.of(context)!.privacy,
                            IconsManager.iconSetting,
                            () {}),
                        const SizedBox(height: 90),
                        GestureDetector(
                          onTap: () {
                            LogoutConfirmationDialog.handle(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.logOut,
                                style: getBoldStyle(
                                    fontSize: 15,
                                    color: ColorManager.shadowGrey),
                              ),
                              const SizedBox(width: 10),
                              SvgPicture.asset(IconsManager.iconCheckout,
                                  width: 28, height: 28),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildElevatedButton(String title, String image, Function fun) {
    return ElevatedButton(
      onPressed:(){
        fun();
      },
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return ColorManager.lightBlueColor;
            }
            return null;
          },
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(image, width: 28, height: 28),
          const SizedBox(width: 10),
          Text(
            title,
            style: getBoldStyle(fontSize: 15, color: ColorManager.shadowGrey),
          ),
        ],
      ),
    );
  }
}
