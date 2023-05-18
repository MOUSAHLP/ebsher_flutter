import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../bloc/category_bloc/category_bloc.dart';
import '../../../bloc/category_bloc/category_event.dart';
import '../../../bloc/category_bloc/category_state.dart';
import '../../../core/services/services_locator.dart';
import '../../resources/values_app.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../resources/style_app.dart';
import '../../resources/color_manager.dart';
import 'home_widget/build_search_widget.dart';
import 'home_widget/build_store_widget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  List image = [
    ImageManager.test1,
    ImageManager.test1,
    ImageManager.test1,
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CategoryBloc, CategoryState>(
          bloc: sl<CategoryBloc>()..add(Category()),
          builder: (context, state) {
            if (state is CategoryLoading) {
              return shimmerNotification();
            } else if (state is CategoryError) {
              return Text(state.error);
            } else if (state is CategorySuccess) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: SizeApp.s23),
                    const BuildStoreWidget(),
                    const SizedBox(height: SizeApp.s23),
                    CarouselSlider(
                      options: CarouselOptions(
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          height: SizeApp.s140,
                          onPageChanged: (index, reason) {
                            sl<CategoryBloc>().add(SetIndex(
                                indexNew: index,
                                lisCategory: state.lisCategory,
                                lisAdvertisment: state.lisAdvertisment));
                          }),
                      items: state.lisAdvertisment.map((advertisment) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: SizeApp.s16),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(RadiusApp.r27),
                                ),
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(RadiusApp.r27),
                                    child: Image.network(
                                      advertisment.photo!,
                                      fit: BoxFit.fill,
                                    )));
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < state.lisAdvertisment.length; i++)
                          context.read<CategoryBloc>().index == i
                              ? Container(
                                  height: SizeApp.s14,
                                  width: SizeApp.s14,
                                  margin: const EdgeInsets.all(PaddingApp.p5),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : Container(
                                  height: SizeApp.s14,
                                  width: SizeApp.s14,
                                  margin: const EdgeInsets.all(PaddingApp.p5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    shape: BoxShape.circle,
                                  ),
                                )
                      ],
                    ),
                    const SizedBox(height: SizeApp.s16),
                    const BuildSearchWidget(),
                    const SizedBox(height: SizeApp.s16),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: SizeApp.s16),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.lisCategory.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: PaddingApp.p14,
                              vertical: PaddingApp.p8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: index % 2 == 0
                                    ? ColorManager.lightYellowColor
                                    : ColorManager.lightBlueColor,
                                borderRadius:
                                    BorderRadius.circular(RadiusApp.r8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(state.lisCategory[index].logo!,
                                    height: SizeApp.s56, width: SizeApp.s56),
                                const SizedBox(height: 2),
                                Text(
                                  state.lisCategory[index].name!,
                                  style: getBoldStyle(
                                      color: ColorManager.whiteColor,
                                      fontSize: 14),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                      ),
                    )
                    ////////////
                  ],
                ),
              );
            } else
              return Text("");
          }),
    );
  }

  Widget shimmerNotification() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 10),
      child: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  shimmerCircle(),
                  shimmerCircle(),
                  shimmerCircle(),
                  shimmerCircle(),
                ],
              ),
              SizedBox(height: 10),
              Shimmer.fromColors(
                baseColor: const Color(0xFFd3d7de),
                highlightColor: const Color(0xFFe2e4e9),
                child: const Card(
                  elevation: 0.0,
                  color: Color.fromRGBO(45, 45, 45, 1.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: SizedBox(
                    width: 350,
                    height: 100,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: SizeApp.s16),
                child: GridView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => shimmerCategory(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget shimmerCircle() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFd3d7de),
      highlightColor: const Color(0xFFe2e4e9),
      child: Card(
        elevation: 0.0,
        color: Color.fromRGBO(45, 45, 45, 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SizedBox(
          width: 80,
          height: 80,
        ),
      ),
    );
  }

  Widget shimmerCategory() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFd3d7de),
      highlightColor: const Color(0xFFe2e4e9),
      child: const Card(
        elevation: 0.0,
        color: Color.fromRGBO(45, 45, 45, 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SizedBox(
          width: 50,
          height: 100,
        ),
      ),
    );
  }
}
