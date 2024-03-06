import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/core/localization_string.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/vendor_details_screen/vendor_details_screen.dart';
import 'package:absher/presentation/screens/vendors_screen/widgets/card_random.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';

import '../../../../models/vendor_model.dart';
import '../../../widgets/accessories/cached_image.dart';

// ignore: must_be_immutable
class CardFavorite extends StatelessWidget {
  VendorModel vendorModel;
  CardFavorite({super.key, required this.vendorModel});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (vendorModel.package?.colorCode != 0 &&
            vendorModel.package?.colorCode != null) {
          AppRouter.push(context, VendorDetailsScreen(id: vendorModel.id!));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: CachedImage(
                  height: 150,
                  width: (MediaQuery.of(context).size.width / 2) - 16,
                  imageUrl: vendorModel.image ?? '',
                  fit: BoxFit.cover,
                  imageSize: ImageSize.mid,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            localizationString(context, vendorModel.name) ?? "",
                            style: getBoldStyle(
                                color: ColorManager.lightBlueColor,
                                fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     StaticRate(
                    //       rate: vendorModel.avgRating,
                    //     ),
                    //     Container(
                    //       decoration: const BoxDecoration(
                    //         borderRadius: BorderRadiusDirectional.only(
                    //           bottomEnd: Radius.circular(20),
                    //           topEnd: Radius.circular(20),
                    //         ),
                    //         color: ColorManager.softYellow,
                    //       ),
                    //       child: Padding(
                    //         padding:
                    //             const EdgeInsets.symmetric(horizontal: 8.0),
                    //         child: Text(
                    //           double.tryParse(vendorModel.avgRating ?? '0')!
                    //               .toStringAsFixed(1),
                    //           style: getBoldStyle(
                    //             color: Colors.white,
                    //             fontSize: FontSizeApp.s12,
                    //           )?.copyWith(
                    //             height: 1.4,
                    //           ),
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
//                  Text(
//                    LocalixationString(context, vendorModel.category?.name) ?? "",
//                    style: getBoldStyle(
//                        color: ColorManager.labelGrey, fontSize: 9),
//                    maxLines: 1,
//                    overflow: TextOverflow.ellipsis,
//                  )

                    const SizedBox(height: 5),
                    InfoCardWithIcon(
                      svgAsset: IconsManager.iconLocation,
                      label: AppLocalizations.of(context)!.address,
                      value: vendorModel.address1 ?? "",
                    ),
                    InfoCardWithIcon(
                      svgAsset: IconsManager.iconLocation,
                      label: AppLocalizations.of(context)!.address,
                      value: vendorModel.address ?? "",
                    ),
                    const SizedBox(height: 5),
                    InfoCardWithIcon(
                      svgAsset: IconsManager.iconPhone,
                      label: AppLocalizations.of(context)!.phone,
                      value: vendorModel.phone1 ?? "",
                    ),

                    InfoCardWithIcon(
                      svgAsset: IconsManager.iconPhone,
                      label: AppLocalizations.of(context)!.phone,
                      value: vendorModel.phone ?? "",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
