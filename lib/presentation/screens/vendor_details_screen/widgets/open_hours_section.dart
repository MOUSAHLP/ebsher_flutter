import 'package:absher/core/localization_string.dart';
import 'package:absher/models/vendor_model.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../resources/assets_manager.dart';

//List<String> getDaysOfWeek(String locale) {
//  final now = DateTime.now();
//  final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
//  List<String> daysList = List.generate(7, (index) => index)
//      .map((value) => DateFormat(DateFormat.WEEKDAY, locale)
//          .format(firstDayOfWeek.add(Duration(days: value))))
//      .toList();
//  List<String> finalList = [
//    daysList[5],
//    daysList[6],
//    daysList[0],
//    daysList[1],
//    daysList[2],
//    daysList[3],
//    daysList[4],
//  ];
//
//  return finalList;
//}

class OpenHourSection extends StatelessWidget {
  const OpenHourSection({Key? key, required this.vendor}) : super(key: key);
  final VendorModel vendor;

  @override
  Widget build(BuildContext context) {
    if (vendor.days == null) return const SizedBox();
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(IconsManager.iconOpenHour),
            SizedBox(
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
          child: Container(
            child: ListView.builder(
              itemCount:vendor.days!.length ,
              shrinkWrap: true,
              itemBuilder: (context, index) {
              return Row(children: [
               Text( LocalixationString(context, vendor.days![index].name!)!,style: getRegularStyle(
                color: ColorManager.shadowGrey,
                fontSize: 12,
                )?.copyWith(height: 1)),
                Spacer(),

                Text(vendor.days![index].pivot!.openAt!,style: getRegularStyle(
                  color: ColorManager.primaryColor,
                  fontSize: 12,
                )?.copyWith(height: 1)),
                SizedBox(width: 5,),
                Icon(Icons.arrow_forward,size: 20,color: ColorManager.primaryColor),
                SizedBox(width: 5,),
                Text(vendor.days![index].pivot!.closeAt!,style: getRegularStyle(
                  color: ColorManager.primaryColor,
                  fontSize: 12,
                )?.copyWith(height: 1))
              ],);
            },),
          )

        ),
      ],
    );
  }
}

class _OpenHourLine extends StatelessWidget {
  const _OpenHourLine({Key? key, required this.day, required this.value})
      : super(key: key);
  final String day;
  final String? value;

  @override
  Widget build(BuildContext context) {
    if (value == null) return const SizedBox();
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                day,
                style: getRegularStyle(
                  color: ColorManager.shadowGrey,
                  fontSize: FontSizeApp.s12,
                ),
              ),
            ),
            Text(
              value!,
              style: getBoldStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSizeApp.s12,
              ),
            )
          ],
        ),
        Divider(
          thickness: 2,
        )
      ],
    );
  }
}
