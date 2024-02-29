import 'package:absher/core/launcher.dart';
import 'package:absher/models/vendor_model.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/widgets/accessories/cached_image.dart';
import 'package:absher/presentation/widgets/custom_button.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyProfile extends StatelessWidget {
  const CompanyProfile({Key? key, required this.vendor}) : super(key: key);
  final VendorModel vendor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              IconsManager.iconAbout,
            //  theme: SvgTheme(currentColor:  ColorManager.lightBlueColor,),
             ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "company profile",
              style: getRegularStyle(
                color: ColorManager.primaryColor,
                fontSize: FontSizeApp.s12,
              ),
            ),
          ],
        ),

        Container(
          width: 20.w,
          padding:  const EdgeInsets.symmetric(vertical: 8.0),
          child: CustomButton(
            onTap: () {


                  launchUrl(
                      Uri.parse(vendor.companyProfile??''),
                      mode: LaunchMode.externalApplication
                  );


            },
            label: "view",
            fillColor: ColorManager.lightBlueColor,
          ),
        )
      ],
    );
  }
}
