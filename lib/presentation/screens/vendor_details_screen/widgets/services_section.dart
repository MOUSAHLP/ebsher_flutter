
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/widgets/accessories/cached_image.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import '../../../../models/vendor_model.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({Key? key,required this.vendor}) : super(key: key);
  final VendorModel vendor;
  @override
  Widget build(BuildContext context) {
    if (vendor.features!.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.services,
            style: getBoldStyle(
              color: ColorManager.primaryColor,
              fontSize: FontSizeApp.s12,
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for(int i=0;i< vendor.features!.length;i++)
              ServiceCard(
                label: vendor.features![i].name??"",
                svgLink:vendor.features![i].icon??"",
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
            CachedImage(imageUrl: svgLink,height: 10,width: 10)
           ,
            const SizedBox(
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
