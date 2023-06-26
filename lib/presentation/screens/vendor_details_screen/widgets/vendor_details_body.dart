
import 'package:absher/core/localization_string.dart';
import 'package:absher/models/vendor_model.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/screens/vendor_details_screen/widgets/recomindation_section.dart';
import 'package:absher/presentation/screens/vendor_details_screen/widgets/services_section.dart';
import 'package:absher/presentation/screens/vendor_details_screen/widgets/social_media_links.dart';
import 'package:absher/presentation/screens/vendors_screen/widgets/card_random.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/style_app.dart';
import 'details_section.dart';
import 'open_hours_section.dart';

class VendorDetailsBody extends StatelessWidget {
  const VendorDetailsBody({Key? key, required this.vendor}) : super(key: key);
  final VendorModel vendor;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (over) {
        over.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        localizationString(context, vendor.name) ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getBoldStyle(
                          color: ColorManager.primaryColor,
                          fontSize: FontSizeApp.s26,
                        ),
                      ),
                    ),
                    IsOpenLabel(
                      isOpen: vendor.isOpen,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        localizationString(context, vendor.description) ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getRegularStyle(
                          color: ColorManager.primaryColor,
                          fontSize: FontSizeApp.s12,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        StaticRate(
                          rate: vendor.avgRating,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadiusDirectional.only(
                              bottomEnd: Radius.circular(20),
                              topEnd: Radius.circular(20),
                            ),
                            color: ColorManager.softYellow,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              double.tryParse(vendor.avgRating ?? '0')!
                                  .toStringAsFixed(1),
                              style: getBoldStyle(
                                color: Colors.white,
                                fontSize: FontSizeApp.s12,
                              )?.copyWith(
                                height: 1.4,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                DetailsSection(
                  vendor: vendor,
                ),
                const Divider(
                  thickness: 2,
                ),
                OpenHourSection(
                  vendor: vendor,
                ),
                SocialMediaLinksSection(
                  vendor: vendor,
                ),
      vendor.socialMedia!.isNotEmpty?   const Divider(
                  thickness: 2,
                ):const SizedBox.shrink(),
                ServicesSection(
                  vendor: vendor,
                ),
                vendor.features!.isNotEmpty?  const Divider(
                  thickness: 2,
                ):const SizedBox.shrink(),
                RecomindationSection(vendor: vendor)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomShapeContainer extends StatelessWidget {
  const CustomShapeContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 58,
          width: 58,
          child: CustomCardCornerShadow(
            clipper: CustomCardCornerClipper(),
            shadow: Shadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 2,
                offset: Directionality.of(context) == TextDirection.ltr
                    ? const Offset(10, 15)
                    : const Offset(-2, 10)),
          ),
        ),
        SvgPicture.asset(
          IconsManager.iconCustomShape,
          height: 80,
          width: 80,
        )
      ],
    );
  }
}

class CustomCardCornerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(size.width * 0.0400000, size.height * 0.2550000);
    path0.cubicTo(
        size.width * 0.0400000,
        size.height * 0.6262500,
        size.width * 0.0400000,
        size.height * 0.6262500,
        size.width * 0.0400000,
        size.height * 0.7500000);
    path0.cubicTo(
        size.width * 0.0287500,
        size.height * 1.0175000,
        size.width * 0.2062500,
        size.height * 1.0075000,
        size.width * 0.2950000,
        size.height);
    path0.cubicTo(
        size.width * 0.4575000,
        size.height * 0.9387500,
        size.width * 0.7425000,
        size.height * 0.7362500,
        size.width * 0.8450000,
        size.height * 0.6550000);
    path0.cubicTo(
        size.width * 0.9462500,
        size.height * 0.5900000,
        size.width * 1.1387500,
        size.height * 0.5100000,
        size.width * 0.8500000,
        size.height * 0.3550000);
    path0.cubicTo(
        size.width * 0.7287500,
        size.height * 0.2587500,
        size.width * 0.4762500,
        size.height * 0.0762500,
        size.width * 0.3050000,
        size.height * 0.0100000);
    path0.cubicTo(
        size.width * 0.1787500,
        size.height * 0.0012500,
        size.width * 0.0237500,
        size.height * -0.0337500,
        size.width * 0.0400000,
        size.height * 0.2550000);
    path0.close();
    return path0;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}

class CustomCardCornerShadow extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  const CustomCardCornerShadow({
    super.key,
    required this.shadow,
    required this.clipper,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CustomCardCornerShadowPainter(
        clipper: clipper,
        shadow: shadow,
      ),
      child: ClipPath(
        clipper: clipper,
      ),
    );
  }
}

class _CustomCardCornerShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _CustomCardCornerShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
