import 'package:absher/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// ignore: must_be_immutable
class  ArrowButton extends StatelessWidget {
  String image;
  Function onTap;
  ArrowButton({super.key, required this.image,required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: SvgPicture.asset(image),
        onTap: () {
          onTap();
        }).handleRotation(context);
  }
}

