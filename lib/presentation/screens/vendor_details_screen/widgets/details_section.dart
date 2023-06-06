import 'package:absher/models/vendor_model.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';

import 'info_details.dart';

class DetailsSection extends StatelessWidget {
  const DetailsSection({Key? key, required this.vendor}) : super(key: key);
  final VendorModel vendor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoDetails(
          svgAsset: IconsManager.iconLocation,
          label: 'عنوان',
          value: vendor.address,
        ),
        InfoDetails(
          svgAsset: IconsManager.iconPhone,
          label: 'رقم الموبايل',
          value: vendor.address,
        ),
        InfoDetails(
          svgAsset: IconsManager.iconFax,
          label: 'فاكس',
          value: '+963-95959595',
        ),
        InfoDetails(
          svgAsset: IconsManager.iconEmail,
          label: 'البريد الالكتروني',
          value: 'Lorem ipsum@gmail.com',
        ),
        InfoDetails(
          svgAsset: IconsManager.iconWeb,
          label: 'ويب',
          value: 'WWW.Lorem ipsum.com',
        ),
      ],
    );
  }
}
