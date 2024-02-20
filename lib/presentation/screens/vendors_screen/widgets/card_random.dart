import 'package:absher/bloc/search_bloc/search_bloc.dart';
import 'package:absher/bloc/search_bloc/search_event.dart';
import 'package:absher/bloc/search_bloc/search_state.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_bloc.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_event.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/vendor_details_screen/vendor_details_screen.dart';
import 'package:absher/presentation/widgets/favorite_heart.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../bloc/favorites_list_bloc/favorites_list_bloc.dart';
import '../../../../bloc/favorites_list_bloc/favorites_list_event.dart';
import '../../../../bloc/favorites_list_bloc/favorites_list_state.dart';
import '../../../../bloc/vendors_list_bloc/vendors_list_state.dart';
import '../../../../core/app_type/type_image.dart';
import '../../../../core/localization_string.dart';

import '../../../../models/vendor_model.dart';
import '../../../resources/assets_manager.dart';
import '../../../widgets/accessories/cached_image.dart';
import 'package:intl/intl.dart' as intl;

class CardRandomWidget extends StatelessWidget {
  final VendorModel vendor;
  final bool fromSearch;

  const CardRandomWidget(
      {super.key, required this.vendor, this.fromSearch = false});

  @override
  Widget build(BuildContext context) {
    List<Widget> card = [
      CircularCard(image: vendor.logo ?? vendor.image ?? ""),
      RectangleCard(image: vendor.logo ?? vendor.image ?? ""),
    ];
    card.shuffle();
    return GestureDetector(
      onTap: () {
        if (vendor.package?.colorCode != 0 &&
            vendor.package?.colorCode != null) {
          AppRouter.push(
            context,
            VendorDetailsScreen(
              id: vendor.id!,
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 54,
          end: 24,
          bottom: 16,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.centerStart,
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(10),
                    bottomEnd: Radius.circular(10),
                    topStart: Radius.circular(50),
                    bottomStart: Radius.circular(50),
                  )),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 48,
                  end: 8,
                  top: 8,
                  bottom: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IntrinsicWidth(
                              child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                localizationString(context, vendor.name) ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: getBoldStyle(
                                  color: ColorManager.primaryColor,
                                  fontSize: 16,
                                ),
                              )),
                              const SizedBox(
                                width: 5,
                              ),
                              vendor.package?.colorCode == 0
                                  ? SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Image.asset(
                                        imageTypeName(0),
                                        // fit:BoxFit.fill
                                      ),
                                    )
                                  : FittedBox(
                                      // height: 30,
                                      // width: 30,
                                      // decoration: BoxDecoration(
                                      //     image: DecorationImage(
                                      //
                                      //         image: AssetImage(imageTypeName(
                                      //             vendor.package!.colorCode ??
                                      //                 0)))),
                                      child: Image.asset(
                                        imageTypeName(
                                            vendor.package!.colorCode ?? 0),
                                        fit: BoxFit.cover,
                                        height: 30,
                                        width: 30,
                                      ),
                                    ),
                            ],
                          )),
                          Text(
                            localizationString(
                                    context, vendor.category?.name) ??
                                "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: getBoldStyle(
                              color: ColorManager.primaryColor,
                              fontSize: 9,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
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
                          const SizedBox(
                            height: 4,
                          ),
                          InfoCardWithIcon(
                            svgAsset: IconsManager.iconLocation,
                            label: 'العنوان',
                            value: vendor.address,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          InfoCardWithIcon(
                            svgAsset: IconsManager.iconPhone,
                            label: 'رقم الهاتف',
                            value: vendor.phone,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if(vendor.packageId == 43)
                          IsOpenLabel(
                            isOpen: vendor.isOpen,
                          ),
                          const SizedBox(height: 20),
                          if (!fromSearch)
                            BlocBuilder<FavoritesListBloc, FavoritesListState>(
                              builder: (context, state) {
                                return FavoriteHeart(
                                  id: vendor.id!,
                                  isToggled: context
                                      .read<FavoritesListBloc>()
                                      .isFavoriteRestaurant(vendor.id!),
                                  onTap: () {
                                    context.read<FavoritesListBloc>().add(
                                        ChangeFavoriteStatusRestaurant(
                                            vendor.id!));
                                  },
                                );
                              },
                            ),
                          if (fromSearch)
                            BlocBuilder<FavoritesListBloc, FavoritesListState>(
                              builder: (context, state) {
                                return FavoriteHeart(
                                  id: vendor.id!,
                                  isToggled: context
                                      .read<FavoritesListBloc>()
                                      .isFavoriteRestaurant(vendor.id!),
                                  onTap: () {
                                    context.read<FavoritesListBloc>().add(
                                        ChangeFavoriteStatusRestaurant(
                                            vendor.id!));
                                  },
                                );
                              },
                            ),
                          const SizedBox(height: 20),
                          vendor.package?.colorCode == null ||
                                  vendor.package?.colorCode == 0
                              ? SizedBox()
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      intl.NumberFormat.compact()
                                          .format(vendor.visits ?? 0),
                                      style: getBoldStyle(
                                        color: ColorManager.primaryColor,
                                      )!
                                          .copyWith(height: 1),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Icon(
                                      Icons.remove_red_eye,
                                      color: ColorManager.primaryColor,
                                      size: 16,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned.directional(
              start: -30,
              textDirection: Directionality.of(context),
              child: card[0],
            )
          ],
        ),
      ),
    );
  }
}

class IsOpenLabel extends StatelessWidget {
  const IsOpenLabel({Key? key, required this.isOpen}) : super(key: key);
  final int? isOpen;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      width: 64,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isOpen == 1 ? ColorManager.backgroundStartColor : null,
          border: Border.all(
            color: isOpen == 1
                ? ColorManager.backgroundStartColor
                : ColorManager.darkRed,
          )),
      child: Center(
          child: Text(
        isOpen == 1
            ? AppLocalizations.of(context)!.open
            : AppLocalizations.of(context)!.closeVendor,
        style: getBoldStyle(
          color: isOpen == 1 ? Colors.white : ColorManager.darkRed,
          fontSize: FontSizeApp.s8,
        ),
      )),
    );
  }
}

class InfoCardWithIcon extends StatelessWidget {
  const InfoCardWithIcon(
      {Key? key, required this.svgAsset, this.label, required this.value})
      : super(key: key);
  final String svgAsset;
  final String? label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    if (label == null || value == null || value == "") return const SizedBox();
    return Row(
      children: [
        SizedBox(
          height: 14,
          width: 14,
          child: SvgPicture.asset(
            svgAsset,
            height: 14,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: getBoldStyle(
                  color: ColorManager.shadowGrey,
                  fontSize: 10,
                )?.copyWith(height: 1),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class StaticRate extends StatelessWidget {
  const StaticRate({Key? key, required this.rate}) : super(key: key);
  final String? rate;

  @override
  Widget build(BuildContext context) {
    double? rating = double.tryParse(rate ?? '0');
    rating ??= 0;
    bool isInteger = (rating % 1) == 0;
    return Row(
      children: [
        for (int index = 1; index <= 5; index++) ...[
          if (!isInteger && index == rating.ceil())
            const Icon(
              Icons.star_half_rounded,
              color: ColorManager.softYellow,
              size: 14,
            )
          else
            Icon(
              rating.toInt() >= index
                  ? Icons.star_rate_rounded
                  : Icons.star_border_rounded,
              color: ColorManager.softYellow,
              size: 14,
            ),
        ],
      ],
    );
  }
}

class CircularCard extends StatelessWidget {
  final String image;

  const CircularCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: ColorManager.boxShadow,
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CachedImage(
            width: 70,
            height: 70,
            imageUrl: image,
          )),
    );
  }
}

class RectangleCard extends StatelessWidget {
  final String image;

  const RectangleCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle,
        boxShadow: ColorManager.boxShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedImage(
          width: 70,
          height: 70,
          imageUrl: image,
        ),
      ),
    );
  }
}
