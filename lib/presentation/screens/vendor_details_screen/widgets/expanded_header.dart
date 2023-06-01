import 'dart:ui';

import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/models/vendor_model.dart';
import 'package:absher/presentation/screens/vendor_details_screen/widgets/vendor_details_body.dart';
import 'package:absher/presentation/widgets/accessories/cached_image.dart';
import 'package:absher/presentation/widgets/circle_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';

class ExpandedHeader extends StatelessWidget {
  const ExpandedHeader({Key? key, required this.vendor}) : super(key: key);

  final VendorModel vendor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sw,
      width: 1.sw,
      color: Colors.redAccent,
      child: Stack(
        children: [
          CachedImage(
            imageUrl: vendor.logo,
            height: 1.sw,
            width: 1.sw,
          ),
          Positioned(
            top: window.padding.top / window.devicePixelRatio,
            child: SizedBox(
              width: 1.sw,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    CircleIconButton(
                      icon: Icons.arrow_back_rounded,
                      onTap: () {
                        AppRouter.pop(context);
                      },
                    ),
                    Spacer(),
                    CircleIconButton(icon: Icons.share),
                    SizedBox(
                      width: 12,
                    ),
                    CircleIconButton(icon: Icons.photo_library_sharp),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 30,
              width: 1.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                color: Colors.white,
              ),
            ),
          ),
          Positioned.directional(
            bottom: 5,
            start: 30,
            textDirection: Directionality.of(context),
            child: Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                CustomShapeContainer(),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(IconsManager.iconFavoriteFilled),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
