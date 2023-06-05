import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/vendors_screen/widgets/card_random.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import '../../../../models/vendors_near_model.dart';
import '../../../widgets/accessories/cached_image.dart';
// ignore: must_be_immutable
class LocationCard extends StatelessWidget {
  VendorsNearModel vendorsNearModel;

  LocationCard({super.key, required this.vendorsNearModel});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Container(
          height: 150,
//        width: 310,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedImage(
                    imageUrl:
                    vendorsNearModel.logo,
                    width: 130,
                    height: 130,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(vendorsNearModel.name!,style: getBoldStyle(color: ColorManager.lightBlueColor,fontSize: 18)),
                    Text(vendorsNearModel.name!,style: getBoldStyle(color: ColorManager.labelGrey),),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        StaticRate(
                          rate: vendorsNearModel
                              .avgRating,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius:
                            BorderRadiusDirectional
                                .only(
                              bottomEnd:
                              Radius.circular(20),
                              topEnd: Radius.circular(20),
                            ),
                            color: ColorManager.softYellow,
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(
                                horizontal: 8.0),
                            child: Text(
                              double.tryParse(vendorsNearModel
                                  .avgRating ??
                                  '0')!
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
                    const SizedBox(
                      height: 2,
                    ),
                    InfoCardWithIcon(
                      svgAsset: IconsManager.iconLocation,
                      label: AppLocalizations.of(context)!
                          .address,
                      value: vendorsNearModel.address!,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    const SizedBox(height: 5),
                    InfoCardWithIcon(
                      svgAsset: IconsManager.iconPhone,
                      label: AppLocalizations.of(context)!
                          .phone,
                      value:vendorsNearModel.phone!,
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
