import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../bloc/authentication_bloc/authertication_bloc.dart';
import '../../core/services/services_locator.dart';
import '../resources/assets_manager.dart';

class FavoriteHeart extends StatelessWidget {
  const FavoriteHeart({
    Key? key,
    required this.id,
    required this.isToggled,
    required this.onTap,
  }) : super(key: key);
  final int id;
  final bool isToggled;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (sl<AuthenticationBloc>().loggedIn) {
          onTap();
        }else{
          toast(AppLocalizations.of(context)!.pleaseLogIn);
        }
      },
      child: isToggled
          ? SvgPicture.asset(
              IconsManager.iconFavoriteFilled,
            )
          : SvgPicture.asset(
              IconsManager.iconFavoriteOutline,
            ),
    );
  }
}
