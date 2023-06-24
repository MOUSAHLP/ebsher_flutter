import 'package:absher/bloc/favorites_list_bloc/favorites_list_bloc.dart';
import 'package:absher/bloc/favorites_list_bloc/favorites_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        onTap();
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
