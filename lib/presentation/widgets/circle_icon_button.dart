import 'package:absher/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({Key? key, this.icon, this.onTap}) : super(key: key);
  final IconData? icon;
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
        child: icon != null
            ? Icon(
                icon,
                color: ColorManager.shadowGrey,
              )
            : Text('!'),
      ),
    );
  }
}
