import 'package:absher/presentation/screens/home_screen/home_widget/build_shimmer_widget.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/home_bloc/home_bloc.dart';
import '../../../bloc/home_bloc/home_event.dart';
import '../../../bloc/home_bloc/home_state.dart';
import '../../../core/localization_string.dart';
import '../../../core/services/services_locator.dart';
import '../../resources/values_app.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../resources/style_app.dart';
import '../../resources/color_manager.dart';
import '../../widgets/custom_cach_image.dart';
import 'home_widget/build_store_widget.dart';
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
                            sl<HomeBloc>().add(SetIndex(
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
                                    child:

                                    Image.network(
                                      advertisment.photo!,
                                      fit: BoxFit.fill,
                                    )
                                ));
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < state.lisAdvertisment.length; i++)
                          context.read<HomeBloc>().index == i
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
                    InkWell(
                      onTap: (){
                        showSearch(context: context, delegate: CustomSearchDelegate(state.lisCategory));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:PaddingApp.p55),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: SizeApp.s10),
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(RadiusApp.r50)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Icon(Icons.search),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: SizeApp.s16),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: SizeApp.s16),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.lisCategory.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (index.isOdd) isBlue = !isBlue;

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: PaddingApp.p14,
                                vertical: PaddingApp.p8),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: !isBlue
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
                                    LocalixationString(context,state.lisCategory[index].name)??""
                                    ,
                                    style: getBoldStyle(
                                        color: ColorManager.whiteColor,
                                        fontSize: 14),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
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
            } else {
              return const Text("");
            }
          }),
    );
  }


}
