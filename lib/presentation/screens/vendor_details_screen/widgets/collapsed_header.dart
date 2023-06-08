import 'dart:ui';

import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/core/app_router/dialog_transition_builder.dart';
import 'package:absher/models/vendor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/localization_string.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/style_app.dart';
import '../../../resources/values_app.dart';
import '../../../widgets/circle_icon_button.dart';

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
                      CircleIconButton(
                        icon: Icons.arrow_back_rounded,
                        onTap: () {
                          AppRouter.pop(context);
                        },
                      ),
                      Expanded(
                        child: Text(
                          LocalixationString(context, vendor.name) ?? '',
                          textAlign: TextAlign.center,
                          style: getBoldStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      CircleIconButton(icon: Icons.share),
                      SizedBox(
                        width: 12,
                      ),
                      CircleIconButton(icon: Icons.photo_library_sharp),
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
