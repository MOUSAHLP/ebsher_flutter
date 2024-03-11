import 'dart:math';

import 'package:absher/bloc/vendors_list_bloc/vendors_list_bloc.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_event.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_state.dart';
import 'package:absher/core/app_enums.dart';
import 'package:absher/models/params/get_vendors_params.dart';
import 'package:absher/models/sub_category_item_model.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/vendors_screen/widgets/build_shimmer_vendors.dart';
import 'package:absher/presentation/screens/vendors_screen/widgets/card_random.dart';
import 'package:absher/presentation/screens/vendors_screen/widgets/search_filter/search_filters.dart';
import 'package:absher/presentation/widgets/accessories/cached_image_provider.dart';
import 'package:absher/presentation/widgets/custom_app_bar_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/localization_string.dart';
import '../../widgets/custom_app_background.dart';
import '../../widgets/custom_error_screen.dart';
import '../../widgets/custom_no_data_screen.dart';

class VendorsScreen extends StatelessWidget {
  const VendorsScreen(
      {Key? key,
      required this.title,
      required this.subCategoryId,
      required this.subCategories})
      : super(key: key);

  final String title;
  final int subCategoryId;
  final List<SubCategoryItemModel> subCategories;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VendorsListBloc>(
      create: (BuildContext context) => VendorsListBloc(
          appliedFilter: GetVendorsParams(subCategoryId: subCategoryId))
        ..add(GetVendorsList(subCategoryId, subCategories))
        ..add(GetCityNameEvent()),
      child: VendorsScreenBody(
        title: title,
        subCategoryId: subCategoryId,
        subCategories: subCategories,
      ),
    );
  }
}

class VendorsScreenBody extends StatelessWidget {
  final String title;
  final int subCategoryId;
  final List<SubCategoryItemModel> subCategories;

  const VendorsScreenBody(
      {super.key,
      required this.title,
      required this.subCategoryId,
      required this.subCategories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAppBackGround(
        child: SafeArea(
          child: Stack(
            children: [
              Stack(
                children: [
                  Positioned.directional(
                    textDirection: Directionality.of(context),
                    start: 0,
                    top: 195,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: 96,
                      decoration: const BoxDecoration(
                          color: ColorManager.softYellow,
                          borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(50))),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.sh,
                child: BlocBuilder<VendorsListBloc, VendorsListState>(
                  buildWhen: (prev, current) {
                    return (prev.screenStates != current.screenStates) ||
                        prev.appliedFilters.subCategoryId !=
                            current.appliedFilters.subCategoryId;
                  },
                  builder: (context, state) {
                    print(
                        '===================== VendorsScreen ======================');
                    // print(state.cityName!.data[0].name);
                    Future.delayed(const Duration(milliseconds: 200))
                        .then((value) {
                      context
                          .read<VendorsListBloc>()
                          .vendorsInnerController
                          .scrollTo(
                            index: subCategories.indexWhere(
                              (SubCategoryItemModel p0) =>
                                  p0.id == state.appliedFilters.subCategoryId,
                            ),
                            duration: const Duration(milliseconds: 100),
                            alignment: 0.4,
                          );
                    });
                    return Column(
                      children: [
                        const SizedBox(height: 70),
                        const SearchFilter(),
                        const SizedBox(height: 20),
                        SizedBox(
                            height: 50,
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: ScrollablePositionedList.separated(
                                reverse: Directionality.of(context) ==
                                    TextDirection.rtl,
                                itemCount: subCategories.length,
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.zero,
                                physics: const ClampingScrollPhysics(),
                                itemScrollController: context
                                    .read<VendorsListBloc>()
                                    .vendorsInnerController,
                                itemBuilder: (context, index1) {
                                  if (index1 >= 0 &&
                                      index1 < subCategories.length) {
                                    return GestureDetector(
                                      onTap: () {
                                        context.read<VendorsListBloc>().add(
                                            ChangeSelectedSubCategory(
                                                subCategories[index1].id!));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              color: Colors.grey[900],
                                              border: Border.all(
                                                  color: state.appliedFilters
                                                              .subCategoryId ==
                                                          subCategories[index1]
                                                              .id
                                                      ? ColorManager
                                                          .primaryColor
                                                      : ColorManager.softYellow,
                                                  width: 3),
                                              image: DecorationImage(
                                                  image: cachedImageProvider(
                                                      subCategories[index1]
                                                          .image),
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.black
                                                          .withOpacity(0.4),
                                                      BlendMode.dstATop),
                                                  fit: BoxFit.cover)),
                                          child: Stack(
                                            children: [
                                              Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 8),
                                                  child: Text(
                                                    localizationString(
                                                            context,
                                                            subCategories[
                                                                    index1]
                                                                .name) ??
                                                        '',
                                                    style: getBoldStyle(
                                                      color: Colors.white,
                                                      fontSize: FontSizeApp.s12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const Text("");
                                  }
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox();
                                },
                              ),
                            )),
                        const SizedBox(height: 20),
                        Expanded(
                          child:
                              BlocConsumer<VendorsListBloc, VendorsListState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state.screenStates == ScreenStates.loading) {
                                return const BuildShimmerVendors();
                              } else if (state.screenStates ==
                                  ScreenStates.error) {
                                return Column(
                                  children: [
                                    CustomErrorScreen(
                                      onTap: () {
                                        context.read<VendorsListBloc>().add(
                                            GetVendorsList(
                                                subCategoryId, subCategories));
                                      },
                                    ),
                                  ],
                                );
                              } else {
                                return state.vendorsList.isNotEmpty
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: NotificationListener<
                                                OverscrollIndicatorNotification>(
                                              onNotification: (over) {
                                                over.disallowIndicator();
                                                return true;
                                              },
                                              child: buildVendorsList(
                                                  context, state),
                                            ),
                                          )
                                        ],
                                      )
                                    : const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: CustomNoDataScreen(),
                                          )
                                        ],
                                      );
                              }
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              Stack(
                children: [
                  CustomAppBarScreens(
                    title: title,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  RefreshIndicator buildVendorsList(
      BuildContext context, VendorsListState state) {
    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<VendorsListBloc>()
            .add(GetVendorsList(subCategoryId, subCategories));
      },
      child: ListView.builder(
        controller: context.read<VendorsListBloc>().scrollController,
        itemCount: state.vendorsList.length + (state.hasMoreData ? 1 : 0),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          if (index < state.vendorsList.length) {
            return CardRandomWidget(
              vendor: state.vendorsList[index],
            );
          } else if (state.isLoading) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Shimmer.fromColors(
                baseColor: const Color(0xFFd3d7de),
                highlightColor: const Color(0xFFe2e4e9),
                child: const Card(
                  elevation: 0.0,
                  color: Color.fromRGBO(45, 45, 45, 1.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(50),
                      bottomStart: Radius.circular(50),
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: SizedBox(
                    width: 350,
                    height: 100,
                  ),
                ),
              ),
            );
          } else if (state.hasMoreData) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_circle_down,
                  color: ColorManager.primaryColor,
                ),
              ),
            );
          } else {
            return Container(); // Return an empty container for other cases
          }
        },
      ),
    );
  }
}
