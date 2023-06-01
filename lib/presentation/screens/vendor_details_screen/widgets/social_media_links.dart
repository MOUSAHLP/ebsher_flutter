import 'package:absher/models/vendor_model.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialMediaLinksSection extends StatelessWidget {
  const SocialMediaLinksSection({Key? key, required this.vendor})
      : super(key: key);
  final VendorModel vendor;
  @override
  Widget build(BuildContext context) {
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
              'مواقع التواصل الاجتماعي',
              style: getRegularStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSizeApp.s12,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  ImageManager.facebookLogo,
                  height: 50,
                  width: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  ImageManager.facebookLogo,
                  height: 50,
                  width: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  ImageManager.facebookLogo,
                  height: 50,
                  width: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  ImageManager.facebookLogo,
                  height: 50,
                  width: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  ImageManager.facebookLogo,
                  height: 50,
                  width: 50,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'تاريخ التأسيس',
                style: getRegularStyle(
                  color: Colors.black,
                  fontSize: FontSizeApp.s12,
                ),
              ),
              Text(
                '10 - 04 - 2020',
                style: getBoldStyle(
                  color: ColorManager.primaryColor,
                  fontSize: FontSizeApp.s12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
