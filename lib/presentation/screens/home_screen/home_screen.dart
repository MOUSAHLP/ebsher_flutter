import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/home_screen/home_widget/build_card_categories.dart';
import 'package:absher/presentation/screens/home_screen/home_widget/build_shimmer_widget.dart';
import 'package:absher/presentation/widgets/ads_carousel_slider.dart';

import 'package:absher/presentation/widgets/custom_error_screen.dart';
import 'package:absher/translations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/home_bloc/home_bloc.dart';
import '../../../bloc/home_bloc/home_event.dart';
import '../../../bloc/home_bloc/home_state.dart';
import '../../../core/services/services_locator.dart';
import '../../../models/advertisement_response.dart';
import '../../resources/values_app.dart';
import 'package:flutter/material.dart';
import '../../resources/color_manager.dart';
import 'home_widget/build_story_widget.dart';
import 'home_widget/search_vendor.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  bool isBlue = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<HomeBloc, HomeState>(
          bloc: sl<HomeBloc>()..add(Home()),
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const BuildShimmerWidget();
            } else if (state is CategoryError) {
              return CustomErrorScreen(
                onTap: () {
                  sl<HomeBloc>().add(Home());
                },
              );
            } else if (state is CategorySuccess) {
              return RefreshIndicator(
                color: ColorManager.primaryColor,
                onRefresh: () async {
                  sl<HomeBloc>().add(Home());
                },
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (over) {
                    over.disallowIndicator();
                    return true;
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.5.h),
                        child: const BuildStoryWidget(),
                      ),
                      state.listAdvertisments.isNotEmpty
                          ? AdsCarouselSlider(
                              ads: state.listAdvertisments,
                            )
                          : AdsCarouselSlider(
                              ads: [
                                AdvertisementsResponse(
                                    image: ImageManager.appLogo)
                              ],
                            ),
                      SizedBox(height: 1.7.h),
                      InkWell(
                        onTap: () {
                          AppRouter.push(context, const SearchVendor());

                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: PaddingApp.p55),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: SizeApp.s10),
                            height: 5.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(RadiusApp.r50)),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.search,
                                  color: ColorManager.primaryColor,
                                ) ,
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .searchPlaceHolder,
                                  style: getBoldStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.3.h),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: 1.sw,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: BuildCardCategories(
                                        category: state.listCategory[0],
                                        isBlue: true,
                                        isEnd: true,
                                      ),
                                    ),
                                    Expanded(
                                      child: BuildCardCategories(
                                        category: state.listCategory[1],
                                        isBlue: false,
                                        isEnd: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 1.sw,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: BuildCardCategories(
                                        category: state.listCategory[2],
                                        isBlue: false,
                                        isEnd: true,
                                      ),
                                    ),
                                    Expanded(
                                      child: BuildCardCategories(
                                        category: state.listCategory[3],
                                        isBlue: true,
                                        isEnd: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 1.sw,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: BuildCardCategories(
                                        category: state.listCategory[4],
                                        isBlue: true,
                                        isEnd: true,
                                      ),
                                    ),
                                    const Expanded(
                                      child: MoreCategoriesCard(
                                        isBlue: false,
                                        isEnd: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Text("");
            }
          }),
    );
  }
}
