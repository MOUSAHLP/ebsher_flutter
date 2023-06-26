import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoDetails extends StatelessWidget {
  const InfoDetails({
    Key? key,
    required this.svgAsset,
    required this.label,
    required this.value,
    this.extraValue,
  }) : super(key: key);
  final String svgAsset;
  final String? label;
  final String? value;
  final String? extraValue;

  @override
  Widget build(BuildContext context) {
    if (label == null || value == null) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            height: 23,
            width: 23,
            child: SvgPicture.asset(
              svgAsset,
              color: ColorManager.softYellow,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label!,
                style: getRegularStyle(
                  color: ColorManager.labelGrey,
                  fontSize: 12,
                )?.copyWith(height: 1),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                value!,
                style: getRegularStyle(
                  color: ColorManager.shadowGrey,
                  fontSize: 14,
                )?.copyWith(height: 1),
              ),
            ],
          )
        ],
      ),
    );
  }
}
