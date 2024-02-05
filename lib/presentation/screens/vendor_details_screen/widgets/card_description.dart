import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization_string.dart';
import '../../../../models/vendor_model.dart';
import '../../../resources/color_manager.dart';

class CardDescription extends StatelessWidget {

  const CardDescription({Key? key, required this.vendor})
      : super(key: key);
  final VendorModel vendor;
  @override
  Widget build(BuildContext context) {
    if(localizationString(context, vendor.description)==null) return SizedBox();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.description,
            style: getRegularStyle(
              color: Colors.black,
              fontSize: FontSizeApp.s12,
            ),
          ),
          Text(
            localizationString(context, vendor.description) ?? '',
            style: getRegularStyle(
              color: ColorManager.primaryColor,
              fontSize: FontSizeApp.s12,
            ),
          ),
        ],
      ),
    );
  }
}
