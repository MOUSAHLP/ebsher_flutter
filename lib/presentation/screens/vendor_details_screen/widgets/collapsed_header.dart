import 'dart:ui';

import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/core/extensions.dart';
import 'package:absher/models/vendor_model.dart';
import 'package:absher/presentation/screens/vendor_details_screen/widgets/dialog_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/localization_string.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/style_app.dart';
class CollapsedHeader extends StatelessWidget {
  const CollapsedHeader({
    required this.toolbarHeight,
    Key? key,
    required this.vendor,
  }) : super(key: key);

  final double toolbarHeight;

  final VendorModel vendor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      color: ColorManager.backgroundEndColor,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: window.padding.top / window.devicePixelRatio),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => AppRouter.pop(context),
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: SvgPicture.asset(
                            IconsManager.iconBackArrow,
                            color: Colors.white,
                          ).handleRotation(context),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          localizationString(context, vendor.name) ?? '',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getBoldStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
//                      SizedBox(
//                        height: 24,
//                        width: 24,
//                        child: SvgPicture.asset(
//                          IconsManager.iconShare,
//                          color: Colors.white,
//                        ).handleRotation(context),
//                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDilog(photosUrls: vendor);
                            },
                          );
                        },
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: SvgPicture.asset(
                            IconsManager.iconGallery,
                            color: Colors.white,
                          ).handleRotation(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
