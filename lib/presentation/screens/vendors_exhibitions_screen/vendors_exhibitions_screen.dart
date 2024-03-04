
import 'package:absher/core/app_enums.dart';
import 'package:absher/models/params/get_vendors_exhibitions_params.dart';
import 'package:absher/models/params/get_vendors_params.dart';
import 'package:absher/models/sub_category_item_model.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/screens/sub_categories_screen/widgets/card_sub_category.dart';

import 'package:absher/presentation/screens/vendors_screen/widgets/build_shimmer_vendors.dart';
import 'package:absher/presentation/screens/vendors_screen/widgets/card_random.dart';
import 'package:absher/presentation/screens/vendors_screen/widgets/search_filter/search_filters.dart';
import 'package:absher/presentation/widgets/accessories/cached_image_provider.dart';
import 'package:absher/presentation/widgets/custom_app_bar_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shimmer/shimmer.dart';
import '../../../bloc/vendors_exhibitions_bloc/vendors_exhibitions_bloc.dart';
import '../../../bloc/vendors_exhibitions_bloc/vendors_exhibitions_event.dart';
import '../../../bloc/vendors_exhibitions_bloc/vendors_exhibitions_state.dart';

import '../../widgets/accessories/cached_image.dart';
import '../../widgets/custom_app_background.dart';
import '../../widgets/custom_error_screen.dart';
import '../../widgets/custom_no_data_screen.dart';

class VendorsExhibitionsScreen extends StatelessWidget {
  const VendorsExhibitionsScreen(
      {Key? key,
      required this.title,
      required this.exhibitionsId,
      required this.image,
     })
      : super(key: key);

  final String title;
  final String image;
  final int exhibitionsId;


  @override
  Widget build(BuildContext context) {
    return BlocProvider<VendorsExhibitionsBloc>(
      create: (BuildContext context) => VendorsExhibitionsBloc(appliedFilter: GetVendorsExhibitionsParams(exhibitionsId: exhibitionsId))..add(GetVendorsList(exhibitionsId,)),

      child: VendorsScreenBody(
        title: title,
        subCategoryId: exhibitionsId,
        image: image,

      ),
    );
  }
}

class VendorsScreenBody extends StatelessWidget {
  final String title;
  final String image;
  final int subCategoryId;


  const VendorsScreenBody(
      {super.key,
      required this.title,
      required this.subCategoryId,
      required this.image,
      });

  @override
  Widget build(BuildContext context) {
    var size = (1.sw - 40) * 98;
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
                child: BlocBuilder<VendorsExhibitionsBloc, VendorsExhibitionsState>(
                  // buildWhen: (prev, current) {
                  //   return (prev.screenStates != current.screenStates) ||
                  //       prev.appliedFilters.exhibitionsId !=
                  //           current.appliedFilters.exhibitionsId;
                  // },
                  builder: (context, state) {
                    print('===================== VendorsScreen ======================');
                    // print(state.cityName!.data[0].name);

                    return Column(
                      children: [
                        const SizedBox(height: 70),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            width: size,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: size / 338,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedImage(
                                imageUrl: image,
                                fit: BoxFit.cover,
                                imageSize: ImageSize.mid,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height:10),
                        Expanded(
                          child:
                              BlocConsumer<VendorsExhibitionsBloc, VendorsExhibitionsState>(
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
                                        context.read<VendorsExhibitionsBloc>().add(
                                            GetVendorsList(
                                                subCategoryId,));
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
      BuildContext context, VendorsExhibitionsState state) {
    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<VendorsExhibitionsBloc>()
            .add(GetVendorsList(subCategoryId));
      },
      child: ListView.builder(
        controller: context.read<VendorsExhibitionsBloc>().scrollController,
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
