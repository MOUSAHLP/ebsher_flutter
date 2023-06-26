import 'dart:ui';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/core/app_router/dialog_transition_builder.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/notification_screen/notification_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/authentication_bloc/authertication_bloc.dart';
import '../../bloc/notification_bloc/notification_bloc.dart';
import '../../bloc/notification_bloc/notification_event.dart';
import '../../bloc/notification_bloc/notification_state.dart';
import '../../core/services/services_locator.dart';
import '../../translations.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  const CustomAppBar(this._scaffoldKey, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 6.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                child: SvgPicture.asset(
                  IconsManager.iconMenu,
                  height: 2.64.h,
                )),
            SvgPicture.asset(
              IconsManager.iconAppAbsher,
              height: 6.h,
            ),
            sl<AuthenticationBloc>().loggedIn?  GestureDetector(
                onTap: () {
                  dialogTransitionBuilder(
                      context,
                      Stack(
                        children: [
                          BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              //this is dependent on the import statment above
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
                                      BlocBuilder<NotificationBloc,
                                              NotificationState>(
                                          bloc: sl<NotificationBloc>(),
                                          builder: (context, state) {
                                            return SizedBox(
                                                width: 20,
                                                child: SwitchListTile(
                                                  value:  context
                                                      .read<NotificationBloc>()
                                                      .isEnable,
                                                  onChanged: (v) {
                                                    if ( context
                                                        .read<NotificationBloc>()
                                                        .isEnable ==
                                                        true) {
                                                      sl<NotificationBloc>().add(
                                                          SetNotificationEnable(
                                                              0));
                                                    } else {
                                                      sl<NotificationBloc>().add(
                                                          SetNotificationEnable(
                                                              1));
                                                    }
                                                  },
                                                  activeColor:
                                                      ColorManager.primaryColor,
                                                ));
                                          }),
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
                                          context, const NotificationScreen());
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
                child: SvgPicture.asset(
                  IconsManager.iconNotification,
                  height: 2.64.h,
                )):const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
