import 'dart:ui';

import 'package:absher/bloc/vendor_details_bloc/vendor_details_event.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_event.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/models/vendor_model.dart';
import 'package:absher/presentation/screens/vendor_details_screen/widgets/vendor_details_body.dart';
import 'package:absher/presentation/widgets/accessories/cached_image.dart';
import 'package:absher/presentation/widgets/circle_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../bloc/favorites_list_bloc/favorites_list_bloc.dart';
import '../../../../bloc/favorites_list_bloc/favorites_list_event.dart';
import '../../../../bloc/favorites_list_bloc/favorites_list_state.dart';
import '../../../../bloc/vendor_details_bloc/vendor_details_bloc.dart';
import '../../../../bloc/vendors_list_bloc/vendors_list_bloc.dart';
import '../../../../core/services/services_locator.dart';
import '../../../resources/assets_manager.dart';
import '../../../widgets/favorite_heart.dart';
import 'dialog_picture.dart';

class ExpandedHeader extends StatelessWidget {
  const ExpandedHeader({Key? key, required this.vendor}) : super(key: key);

  final VendorModel vendor;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sw,
      width: 1.sw,
      color: Colors.white,
      child: Stack(
        children: [
          InkWell(
            onTap: (){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.transparent,
                    content:  CachedImage(
                      imageUrl: vendor.image??vendor.logo,
                      height: 1.sw,
                      width: 1.sw,
                    ),

                  );
                },
              );
            },
            child: CachedImage(
              imageUrl: vendor.image??vendor.logo,
              height: 1.sw,
              width: 1.sw,
            ),
          ),
          Positioned(
            top: window.padding.top / window.devicePixelRatio,
            child: SizedBox(
              width: 1.sw,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    CircleIconButton(
                      svgAsset: IconsManager.iconBackArrow,
                      onTap: () {
                        AppRouter.pop(context);
                      },
                    ),
                    const Spacer(),
                    //  CircleIconButton(svgAsset: IconsManager.iconShare),
                    const SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDilog(photosUrls: vendor);
                            },
                          );
                        },
                        child: const CircleIconButton(
                            svgAsset: IconsManager.iconGallery)),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 30,
              width: 1.sw,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                color: Colors.white,
              ),
            ),
          ),
          BlocBuilder<FavoritesListBloc, FavoritesListState>(
            builder: (context, state) {
              return   Positioned.directional(
                bottom: 5,
                start: 30,
                textDirection: Directionality.of(context),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const CustomShapeContainer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: FavoriteHeart(
                        id: vendor.id!,
                        isToggled: context.read<FavoritesListBloc>().isFavoriteRestaurant(vendor.id!),
                        onTap: () {
                          context.read<FavoritesListBloc>().add(
                              ChangeFavoriteStatusRestaurant(
                                  vendor.id!));
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

        ],
      ),
    );
  }
}
