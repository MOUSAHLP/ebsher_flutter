import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/screens/location_screen/widgets/marker.dart';
import 'package:flutter/material.dart';

import '../../../resources/style_app.dart';
class FilterButtonLocation extends StatelessWidget {
  FilterButtonLocation({Key? key, required this.isSelected, required this.label,required this.color,required this.image})
      : super(key: key);
  final bool isSelected;
  final String label;
  String image;
  String color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: getBoldStyle(
                color: isSelected
                    ? ColorManager.softYellow
                    : ColorManager.labelGrey,
                fontSize: FontSizeApp.s16,
              ),
            ),
            Visibility(
                visible: isSelected,
                child: MarkerWidget(image: image,colors: color,)
//              Icon(
//                Icons.circle,
//                size: 16,
//                color: ColorManager.softYellow,
//              ),
            )
          ],
        ),
        Divider(
          thickness: 2,
        ),
      ],
    );
  }
}