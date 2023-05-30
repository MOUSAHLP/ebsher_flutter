import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/resources/values_app.dart';
import 'package:absher/presentation/screens/sub_categories_screen/sub_categories_screen.dart';
import 'package:absher/presentation/screens/vendors_screen/vendors_screen.dart';

import 'package:flutter/material.dart';

import '../../../../core/app_router/app_router.dart';
import '../../../../core/localization_string.dart';
import '../../../../models/category_response.dart';
import '../../../widgets/accessories/cached_image.dart';

class BuildCardCategories extends StatelessWidget {
  final CategoyResponse category;
  final bool isBlue;

  const BuildCardCategories(
      {super.key, required this.category, required this.isBlue});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRouter.push(
          context,
          VendorsScreen(
              title: LocalixationString(context, category.name) ?? "",
              categoryId: category.id!),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: PaddingApp.p14, vertical: PaddingApp.p8),
        child: Container(
          decoration: BoxDecoration(
              color: !isBlue
                  ? ColorManager.lightYellowColor
                  : ColorManager.lightBlueColor,
              borderRadius: BorderRadius.circular(RadiusApp.r8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedImage(
                  imageUrl: category.logo!,
                  width: SizeApp.s56,
                  height: SizeApp.s56),
              const SizedBox(height: 2),
              Text(
                LocalixationString(context, category.name) ?? "",
                style:
                    getBoldStyle(color: ColorManager.whiteColor, fontSize: 14),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
