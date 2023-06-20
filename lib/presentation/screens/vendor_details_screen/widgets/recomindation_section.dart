
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/favorites_screen/widgets/card_favorite.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../models/vendor_model.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
class RecomindationSection extends StatelessWidget {
  const RecomindationSection({Key? key, required this.vendor})
      : super(key: key);
  final VendorModel vendor;
  @override
  Widget build(BuildContext context) {
    if (vendor.recomindation!.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(IconsManager.iconLinks),
            SizedBox(
              width: 8,
            ),
            Text(
             AppLocalizations.of(context)!.recomindation,
              style: getRegularStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSizeApp.s12,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 300,
          width: 1.sw,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: vendor.recomindation?.length,
            itemBuilder: (context, index) {
              return CardFavorite(vendorModel: vendor.recomindation![index]);
            },
          ),
        ),
      ],
    );
  }
  }

