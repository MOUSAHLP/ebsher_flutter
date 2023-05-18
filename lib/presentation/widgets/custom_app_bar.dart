import 'package:absher/bloc/authentication_bloc/authentication_event.dart';
import 'package:absher/bloc/authentication_bloc/authertication_bloc.dart';
import 'package:absher/core/services/services_locator.dart';
import 'package:absher/presentation/screens/auth_screen/account_screen.dart';

import '../resources/values_app.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PaddingApp.p22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              sl<AuthenticationBloc>().add(LoggedOut());
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => AccountScreen(),
                  ),
                  (Route<dynamic> route) => false);
            },
            child: SvgPicture.asset(IconsManager.iconNotification),
          ),
          SvgPicture.asset(IconsManager.iconAppAbsher),
          SvgPicture.asset(IconsManager.iconMenu),
        ],
      ),
    );
  }
}
