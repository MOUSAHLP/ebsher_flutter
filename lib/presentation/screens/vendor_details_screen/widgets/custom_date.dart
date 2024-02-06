import 'package:absher/core/formatter.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';

import '../../../../models/vendor_model.dart';

class CustomDate extends StatelessWidget {


  const CustomDate({Key? key, required this.vendor})
      : super(key: key);
  final VendorModel vendor;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.craatDate,
            style: getRegularStyle(
              color: Colors.black,
              fontSize: FontSizeApp.s12,
            ),
          ),
          Text(
            Formatter.formatDateOnly(context, vendor.customDate!),
            style: getBoldStyle(
              color: ColorManager.primaryColor,
              fontSize: FontSizeApp.s12,
            ),
          ),
        ],
      ),
    );
  }
}
