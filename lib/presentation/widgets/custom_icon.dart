import 'package:absher/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({Key? key, required this.svgAsset}) : super(key: key);
  final String svgAsset;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      child: SvgPicture.asset(
        svgAsset,
        color: Colors.white,
      ).handleRotation(context),
    );
  }
}
