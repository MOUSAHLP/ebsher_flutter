import 'package:absher/core/extensions.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/assets_manager.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({Key? key, required this.svgAsset, this.onTap})
      : super(key: key);
  final String svgAsset;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        height: 40,
        width: 40,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            svgAsset,
            color: ColorManager.primaryColor,
          ).handleRotation(context),
        ),
      ),
    );
  }
}
