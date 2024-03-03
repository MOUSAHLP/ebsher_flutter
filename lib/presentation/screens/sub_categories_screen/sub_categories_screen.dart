import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/models/advertisement_response.dart';
import 'package:absher/presentation/screens/sub_categories_screen/widgets/build_shimmer_sub.dart';
import 'package:absher/presentation/screens/sub_categories_screen/widgets/card_sub_category.dart';
import 'package:absher/presentation/widgets/custom_app_bar_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/sub_category_bloc/sub_category_bloc.dart';
import '../../../bloc/sub_category_bloc/sub_category_event.dart';
import '../../../bloc/sub_category_bloc/sub_category_state.dart';
import '../../../core/localization_string.dart';
import '../../../core/services/services_locator.dart';
import '../../resources/assets_manager.dart';
import '../../widgets/ads_carousel_slider.dart';
import '../../widgets/custom_app_background.dart';
import '../../widgets/custom_error_screen.dart';
import '../../widgets/custom_no_data_screen.dart';
import '../vendors_screen/vendors_screen.dart';

class SubCategoriesScreen extends StatelessWidget {
  final String title;
  final int id;

  const SubCategoriesScreen({super.key, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SubCategoryBloc>(
        create: (BuildContext context) =>
            sl<SubCategoryBloc>()..add(GetSubCategory(id)),
        child: SubCategoryBody(id: id, title: title));
  }
}

class SubCategoryBody extends StatelessWidget {
  final String title;
  final int id;

  const SubCategoryBody({super.key, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return CustomAppBackGround(
        child: SafeArea(
            child: Stack(children: [
      BlocBuilder<SubCategoryBloc, SubCategoryState>(builder: (context, state) {
        if (state is SubCategoryLoading) {
          return const BuildShimmerSubCategory();
        } else if (state is SubCategoryError) {
          return CustomErrorScreen(
            onTap: () {
              context.read<SubCategoryBloc>().add(GetSubCategory(id));
            },
          );
        } else if (state is SubCategorySuccess) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<SubCategoryBloc>().add(GetSubCategory(id));
            },
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (over) {
                over.disallowIndicator();
                return true;
              },
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  state.mainAds.isNotEmpty
                      ? AdsCarouselSlider(
                          ads: state.mainAds,
                        )
                      :const SizedBox(),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SizedBox(
                      child: state.subCategories.isNotEmpty
                          ? ListView.builder(
                              itemCount: state.subCategories.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      AppRouter.push(
                                        context,
                                        VendorsScreen(
                                          title: localizationString(
                                              context,
                                              state
                                                  .subCategories[index].name!)!,
                                          subCategoryId:
                                              state.subCategories[index].id!,
                                          subCategories: state.subCategories,
                                        ),
                                      );
                                    },
                                    child: CardSubCategory(
                                      title: localizationString(context,
                                          state.subCategories[index].name!)!,
                                      image: state.subCategories[index].image ??
                                          "",
                                    ));
                              },
                            )
                          : const Center(child: CustomNoDataScreen()),
                    ),
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            ),
          );
        } else {
          return const Text("");
        }
      }),
      Stack(
        children: [
          CustomAppBarScreens(
            title: title,
          )
        ],
      ),
    ])));
  }
}
