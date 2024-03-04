import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterButton extends StatelessWidget {
  const FilterButton(
      {Key? key, required this.isSelected, required this.label, this.onTab})
      : super(key: key);
  final bool isSelected;
  final String label;
  final Function()? onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTab != null) {
          onTab!();
        }
      },
      child: Container(
        width: 1.sw,
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: isSelected
                      ? getBoldStyle(color: ColorManager.primaryColor)
                      : getBoldStyle(color: ColorManager.primaryColor),
                ),
                Visibility(
                  visible: isSelected,
                  child: const Icon(
                    Icons.circle,
                    size: 16,
                    color: ColorManager.primaryColor,
                  ),
                )
              ],
            ),
            const Divider(
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}
