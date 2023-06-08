import 'package:absher/presentation/screens/home_screen/home_widget/build_card_categories.dart';
import 'package:absher/presentation/screens/home_screen/home_widget/build_shimmer_widget.dart';
import 'package:absher/presentation/widgets/ads_carousel_slider.dart';

import 'package:absher/presentation/widgets/custom_error_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/home_bloc/home_bloc.dart';
import '../../../bloc/home_bloc/home_event.dart';
import '../../../bloc/home_bloc/home_state.dart';
import '../../../core/services/services_locator.dart';
import '../../resources/values_app.dart';
import 'package:flutter/material.dart';
import '../../resources/color_manager.dart';
import 'home_widget/build_story_widget.dart';
import 'home_widget/search_result_screen.dart';

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
                        padding: EdgeInsets.symmetric(vertical: 2.65.h),
                        child: const BuildStoryWidget(),
                      ),
                      AdsCarouselSlider(
                        ads: state.lisAdvertisment,
                      ),
                      SizedBox(height: 1.7.h),
                      InkWell(
                        onTap: () {
                          showSearch(
                              context: context,
                              delegate:
                                  CustomSearchDelegate(state.lisCategory));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: PaddingApp.p55),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: SizeApp.s10),
                            height: 3.5.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(RadiusApp.r50)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Icon(
                                  Icons.search,
                                  color: ColorManager.primaryColor,
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
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 1.sw,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: BuildCardCategories(
                                              category: state.lisCategory[0],
                                              isBlue: true,
                                              isEnd: true,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 9.2.w,
                                          ),
                                          Expanded(
                                            child: BuildCardCategories(
                                              category: state.lisCategory[1],
                                              isBlue: false,
                                              isEnd: false,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  
                                  children: [
                                    SizedBox(
                                      width: 1.sw,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: BuildCardCategories(
                                              category: state.lisCategory[2],
                                              isBlue: true,
                                              isEnd: true,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 9.2.w,
                                          ),
                                          Expanded(
                                            child: BuildCardCategories(
                                              category: state.lisCategory[3],
                                              isBlue: false,
                                              isEnd: false,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 1.sw,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: BuildCardCategories(
                                              category: state.lisCategory[4],
                                              isBlue: true,
                                              isEnd: true,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 9.2.w,
                                          ),
                                          const Expanded(
                                            child: MoreCategoryCard(
                                              isBlue: false,
                                              isEnd: false,
                                            ),
                                          ),
                                        ],
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
