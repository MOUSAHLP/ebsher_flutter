import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'خدمات',
            style: getBoldStyle(
              color: ColorManager.primaryColor,
              fontSize: FontSizeApp.s12,
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ServiceCard(
                label: 'انترنت مجاني',
                svgLink: IconsManager.iconWifi,
              ),
              ServiceCard(
                label: 'يسمح بدخول الكلاب',
                svgLink: IconsManager.iconDogs,
              ),
              ServiceCard(
                label: 'يوجد العاب للاطفال',
                svgLink: IconsManager.iconKids,
              ),
              ServiceCard(
                label: 'مسموح الدخان',
                svgLink: IconsManager.iconFire,
              ),
              ServiceCard(
                label: 'يوجد حفلات',
                svgLink: IconsManager.iconMusic,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({Key? key, required this.svgLink, required this.label})
      : super(key: key);
  final String svgLink;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.lightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              svgLink,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              label,
              style: getRegularStyle(
                color: Colors.black,
                fontSize: FontSizeApp.s8,
              ),
            )
          ],
        ),
      ),
    );
  }
}
