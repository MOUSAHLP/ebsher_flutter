import 'package:absher/bloc/location_bloc/location_event.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/vendors_screen/widgets/card_random.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../bloc/favorites_list_bloc/favorites_list_bloc.dart';
import '../../../../bloc/favorites_list_bloc/favorites_list_event.dart';
import '../../../../bloc/favorites_list_bloc/favorites_list_state.dart';
import '../../../../bloc/location_bloc/location_bloc.dart';
import '../../../../bloc/location_bloc/location_state.dart';
import '../../../../core/localization_string.dart';
import '../../../../models/vendor_model.dart';

import '../../../widgets/accessories/cached_image.dart';
import '../../../widgets/favorite_heart.dart';
import '../../vendor_details_screen/vendor_details_screen.dart';
import '../../vendor_details_screen/widgets/vendor_details_body.dart';

// ignore: must_be_immutable
class LocationCard extends StatelessWidget {
  VendorModel vendorModel;

  LocationCard({super.key, required this.vendorModel});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          AppRouter.push(
              context,
              VendorDetailsScreen(
                id: vendorModel.id!,

              ));
        },
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 1.sw-80,
               // height: 160,
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
                          imageUrl: vendorModel.image,
                          width: 130,
                          height: 130,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                localizationString(context, vendorModel.name!) ??
                                    "",
                                style: getBoldStyle(
                                    color: ColorManager.lightBlueColor,
                                    fontSize: 18)),
                            Text(
                              localizationString(
                                      context, vendorModel.category?.name!) ??
                                  "",
                              style: getBoldStyle(color: ColorManager.labelGrey),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                StaticRate(
                                  rate: vendorModel.avgRating,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      double.tryParse(
                                              vendorModel.avgRating ?? '0')!
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
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InfoCardWithIcon(
                                        svgAsset: IconsManager.iconLocation,
                                        label:
                                            AppLocalizations.of(context)!.address,
                                        value: vendorModel.address!,
                                      ),
                                      const SizedBox(height: 7),
                                      InfoCardWithIcon(
                                        svgAsset: IconsManager.iconPhone,
                                        label: AppLocalizations.of(context)!.phone,
                                        value: vendorModel.phone!,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            Positioned.directional(
              textDirection: Directionality.of(context),
              end: -10,
              bottom: -14,
              child:  Stack(
               alignment: Alignment.center,
               children: [
                 const CustomShapeContainer(),
                 Padding(
                   padding: const EdgeInsets.only(right: 6),
                   child: BlocBuilder<FavoritesListBloc, FavoritesListState>(
                     builder: (context, state) {
                       return FavoriteHeart(
                         id:  vendorModel.id!,
                         isToggled: context.read<FavoritesListBloc>().isFavoriteRestaurant(vendorModel.id!),
                         onTap: () {
                           context.read<FavoritesListBloc>().add(
                               ChangeFavoriteStatusRestaurant(
                                   vendorModel.id!));
                         },
                       );
                     },
                   ),
                 ),
               ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
