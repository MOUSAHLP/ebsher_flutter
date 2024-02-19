import 'package:absher/core/localization_string.dart';
import 'package:absher/models/vendor_model.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/formatter.dart';
import '../../../resources/assets_manager.dart';

class OpenHourSection extends StatelessWidget {
  const OpenHourSection({Key? key, required this.vendor}) : super(key: key);
  final VendorModel vendor;

  @override
  Widget build(BuildContext context) {
    if (vendor.days!.isEmpty) return const SizedBox();
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(IconsManager.iconOpenHour),
            const SizedBox(
              width: 8,
            ),
            Text(
              AppLocalizations.of(context)!.timeOpen,
              style: getRegularStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSizeApp.s12,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16,
          ),
          child: ListView.builder(
            itemCount:vendor.days!.length ,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
            return Row(children: [
             Text( localizationString(context, vendor.days![index].name!)!,style: getRegularStyle(
              color: ColorManager.shadowGrey,
              fontSize: 12,
              )?.copyWith(height: 1)),
              const Spacer(),

              Text(Formatter.formatTime(vendor.days![index].pivot!.openAt!),style: getRegularStyle(
                color: ColorManager.primaryColor,
                fontSize: 12,
              )?.copyWith(height: 1)),
              const SizedBox(width: 5,),
              const Icon(Icons.arrow_forward,size: 20,color: ColorManager.primaryColor),
              const SizedBox(width: 5,),
              Text(Formatter.formatTime(vendor.days![index].pivot!.closeAt!),style: getRegularStyle(
                color: ColorManager.primaryColor,
                fontSize: 12,
              )?.copyWith(height: 1))
            ],);
          },)

        ),
      ],
    );
  }
}

