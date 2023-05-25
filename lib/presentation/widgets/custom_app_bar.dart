import 'dart:ui';

import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/core/app_router/dialog_transition_builder.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/notification_screen/notification_screen.dart';
import 'package:flutter/cupertino.dart';
import '../../translations.dart';
import '../resources/values_app.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey;

  CustomAppBar(this._scaffoldKey);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: PaddingApp.p22, vertical: PaddingApp.p10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: SvgPicture.asset(
                    IconsManager.iconMenu,
                    width: 35,
                    height: 22,
                  )),
            ],
          ),
          SvgPicture.asset(IconsManager.iconAppAbsher),
          GestureDetector(
              onTap: () {
                dialogTransitionBuilder(
                    context,
                    Stack(
                      children: [
                        BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: 5.0,
                                sigmaY:
                                    5.0), //this is dependent on the import statment above
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.transparent))),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, right: 10),
                          child: AlertDialog(
                            alignment: Alignment.topLeft,
                            content: SingleChildScrollView(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                    onTap: () {
                                      AppRouter.pop(context);
                                    },
                                    child: const Icon(
                                      Icons.clear,
                                      color: ColorManager.primaryColor,
                                    )),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: 20,
                                        child: SwitchListTile(
                                          value: true,
                                          onChanged: (v) {},
                                          activeColor:
                                              ColorManager.primaryColor,
                                        )),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .turnNotification,
                                        style: getMediumStyle(
                                            color: const Color(0xff707070),
                                            fontSize: 15)),
                                  ],
                                ),
                                const Center(
                                    child: Divider(
                                  color: Colors.black,
                                )),
                                Center(
                                    child: GestureDetector(
                                  onTap: () {
                                    AppRouter.pushReplacement(
                                        context, NotificationScreen());
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .showNotication,
                                    style: getBoldStyle(
                                        color: ColorManager.primaryColor),
                                  ),
                                ))
                              ],
                            )),
                          ),
                        ),
                      ],
                    ));
              },
              child: SvgPicture.asset(IconsManager.iconNotification)),
        ],
      ),
    );
  }
}
