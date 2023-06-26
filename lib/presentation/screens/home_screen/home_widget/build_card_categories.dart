import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/resources/values_app.dart';
import 'package:absher/presentation/screens/categories_screen/categories_screen.dart';
import 'package:absher/presentation/screens/sub_categories_screen/sub_categories_screen.dart';
import 'package:absher/translations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_router/app_router.dart';
import '../../../../core/localization_string.dart';
import '../../../../models/category_response.dart';
import '../../../widgets/accessories/cached_image.dart';

class BuildCardCategories extends StatefulWidget {
  final CategoyResponse category;
  final bool isBlue;
  final bool isEnd;

  const BuildCardCategories(
      {super.key,
      required this.category,
      required this.isBlue,
      required this.isEnd});

  @override
  State<BuildCardCategories> createState() => _BuildCardCategoriesState();
}

class _BuildCardCategoriesState extends State<BuildCardCategories> {
  double size = 13.2.h;
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.isEnd ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              pressed = true;
            });
            Future.delayed(const Duration(milliseconds: 300)).then((value) {
              AppRouter.push(
                  context,
                  SubCategoriesScreen(
                    title:
                        localizationString(context, widget.category.name) ?? "",
                    id: widget.category.id!,
                  ));
              setState(() {
                pressed = false;
              });
            });
          },
          child: AnimatedContainer(
            height: !pressed ? 13.2.h : 13.2.h + 2.h,
            width: !pressed ? 13.2.h : 13.2.h + 2.h,
            decoration: BoxDecoration(
                color: pressed
                    ? Colors.grey
                    : !widget.isBlue
                        ? ColorManager.lightYellowColor
                        : ColorManager.lightBlueColor,
                borderRadius: BorderRadius.circular(RadiusApp.r8)),
            duration: const Duration(milliseconds: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CachedImage(
                    imageUrl: widget.category.thumbnail!,
                    imageSize: ImageSize.small,
                    fit: BoxFit.contain,
                    width: 6.6.h,
                    height: 6.6.h,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Text(
                    localizationString(context, widget.category.name) ?? "",
                    style: getBoldStyle(
                            color: ColorManager.whiteColor, fontSize: 12)
                        ?.copyWith(height: 1),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MoreCategoryCard extends StatefulWidget {
  final bool isBlue;
  final bool isEnd;

  const MoreCategoryCard(
      {super.key, required this.isBlue, required this.isEnd});

  @override
  State<MoreCategoryCard> createState() => _MoreCategoryCardState();
}

class _MoreCategoryCardState extends State<MoreCategoryCard> {
  double size = 13.2.h;
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.isEnd ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              pressed = true;
            });
            Future.delayed(const Duration(milliseconds: 300)).then((value) {
              AppRouter.push(
                context,
                const CategoriesScreen(),
              );
              setState(() {
                pressed = false;
              });
            });
          },
          child: AnimatedContainer(
            height: !pressed ? 13.2.h : 13.2.h + 2.h,
            width: !pressed ? 13.2.h : 13.2.h + 2.h,
            decoration: BoxDecoration(
                color: pressed
                    ? Colors.grey
                    : !widget.isBlue
                        ? ColorManager.lightYellowColor
                        : ColorManager.lightBlueColor,
                borderRadius: BorderRadius.circular(RadiusApp.r8)),
            duration: const Duration(milliseconds: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.more_horiz,
                    size: 6.6.h,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    AppLocalizations.of(context)!.more,
                    style: getBoldStyle(
                            color: ColorManager.whiteColor, fontSize: 12)
                        ?.copyWith(height: 1),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
