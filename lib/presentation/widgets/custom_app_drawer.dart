import 'dart:ui';

import 'package:absher/bloc/authentication_bloc/authertication_bloc.dart';
import 'package:absher/bloc/language_bloc/language_event.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/values_app.dart';

import 'package:absher/presentation/widgets/accessories/cached_image.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../bloc/bottom_bloc/bottom_bloc.dart';
import '../../bloc/bottom_bloc/bottom_event.dart';
import '../../bloc/language_bloc/language_bloc.dart';
import '../../core/services/services_locator.dart';
import '../../data/data_resource/local_resource/data_store.dart';
import '../resources/color_manager.dart';
import '../resources/style_app.dart';
import '../screens/about_screen/about_screen.dart';
import '../screens/auth_screen/sign_in_screen.dart';
import '../screens/privacy_screen/privacy_screen.dart';
import 'dialogs/logout_confirmation_dialog.dart';

// ignore: must_be_immutable
class CustomAppDrawer extends StatelessWidget {
  CustomAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: (){
            AppRouter.pop(context);
          },
          child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0), //this is dependent on the import statment above
              child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent)),),
        ),
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
                          child: sl<AuthenticationBloc>().loggedIn? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(RadiusApp.r50),
                                      child: CachedImage(
                                        imageUrl: context
                                            .read<AuthenticationBloc>()
                                            .loginResponse!
                                            .image,
                                        imageSize: ImageSize.small,

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
                              ]):Container(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        buildElevatedButton(
                            AppLocalizations.of(context)!.profile,
                            IconsManager.iconUserSetting, () {
                          sl<BottomBloc>().add(NewBottomChange(4));
                          AppRouter.pop(context);
                        }),
                        buildElevatedButton(
                            AppLocalizations.of(context)!.favorite,
                            IconsManager.iconStar, () {
                          sl<BottomBloc>().add(NewBottomChange(1));
                          AppRouter.pop(context);
                        }),
                        buildElevatedButton(
                            AppLocalizations.of(context)!.language,
                            IconsManager.iconWorld, () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                        child: Text("English",
                                            style: getBoldStyle(
                                                color:
                                                    ColorManager.primaryColor,
                                                fontSize: 16)),
                                        onTap: () {
                                          if (DataStore.instance.lang != "en") {
                                            sl<LanguageBloc>()
                                                .add(NewLanguageChange("en"));
                                            AppRouter.pop(context);
                                          } else {
                                            AppRouter.pop(context);
                                          }
                                        }),
                                    GestureDetector(
                                        onTap: () {
                                          if (DataStore.instance.lang != "ar") {
                                            sl<LanguageBloc>()
                                                .add(NewLanguageChange("ar"));
                                            AppRouter.pop(context);
                                          } else {
                                            AppRouter.pop(context);
                                          }
                                        },
                                        child: Text("عربي",
                                            style: getBoldStyle(
                                                color:
                                                    ColorManager.primaryColor,
                                                fontSize: 14))),
                                  ],
                                ),
                              );
                            },
                          );
                        }),
                        buildElevatedButton(AppLocalizations.of(context)!.about,
                            IconsManager.iconAbout, () {
                          AppRouter.push(context, const AboutScreen());
                        }),
                        buildElevatedButton(
                            AppLocalizations.of(context)!.privacy,
                            IconsManager.iconSetting, () {
                          AppRouter.push(context, const PrivacyScreen());
                        }),
                        const SizedBox(height: 90),
                        sl<AuthenticationBloc>().loggedIn?     GestureDetector(
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
                        ):
                        GestureDetector(
                          onTap: () {
                            AppRouter.push(context, const SignInConfirmationScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.signIn,
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

  AlertDialog alert = AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
            child: Text("English",
                style: getBoldStyle(
                    color: ColorManager.primaryColor, fontSize: 16)),
            onTap: () {
              DataStore.instance.setLang("en");
            }),
        GestureDetector(
            onTap: () {

              DataStore.instance.setLang("ar");
            },
            child: Text("عربي",
                style: getBoldStyle(
                    color: ColorManager.primaryColor, fontSize: 14))),
      ],
    ),
  );

  Widget buildElevatedButton(String title, String image, Function fun) {
    return ElevatedButton(
      onPressed: () {
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
