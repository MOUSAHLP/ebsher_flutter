import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/screens/gategories_screen/widgets/build_shimmer_categories.dart';
import 'package:absher/presentation/screens/gategories_screen/widgets/card_random.dart';
import 'package:absher/presentation/widgets/custom_app_bar_screens.dart';
import 'package:absher/presentation/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../bloc/sub_categories_bloc/sub_categories_bloc.dart';
import '../../../bloc/sub_categories_bloc/sub_categories_event.dart';
import '../../../bloc/sub_categories_bloc/sub_categories_state.dart';
import '../../../core/services/services_locator.dart';
import '../../widgets/custom_app_background.dart';
import '../../widgets/custom_error_screen.dart';
import '../../widgets/custom_no_data_screen.dart';

class CategoriesScreen extends StatelessWidget {
  String title;
  int idCategory;
  CategoriesScreen({super.key, required this.title,required this.idCategory});
  @override
  Widget build(BuildContext context) {
    return CustomAppBackGround(
        child: SafeArea(
            child: Stack(
          children: [
          Stack(
            children: [
              Positioned.directional(
                textDirection: Directionality.of(context),
                end: 0,
                top: 110,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: 100,
                  decoration: const BoxDecoration(
                      color: ColorManager.softYellow,
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(50))),
                )),
            ],
          ),
        BlocBuilder<SubCategoriesBloc, SubCategoriesState>(
            bloc: sl<SubCategoriesBloc>()..add(SubCategories(idCategory)),
            builder: (context, state) {
              if (state is SubCategoriesLoading) {
                return const BuildShimmerGategories();
              } else if (state is SubCategoriesError) {
                return CustomErrorScreen(
                  onTap: () {
                    sl<SubCategoriesBloc>().add(SubCategories(idCategory));
                  },
                );}
               else if (state is SubCategoriesSuccess) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 80),
                      Center(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            height: 50,
                            width: MediaQuery.of(context).size.width - 40,
                            child: Row(
                              children: [],
                            )),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child:state.lisSubCategory.isNotEmpty? ListView.builder(
                          itemBuilder: (context, index) {
                            return cardRandomWidget(
                              categories: state.lisSubCategory[index],
                            );
                          },
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.lisSubCategory.length,
                          shrinkWrap: true,
                        ):Center(child: CustomNoDataScreen()),
                      ),
                    ],
                  ),
                );
              } else {
                return Text("");
              }
            }),
        Stack(
          children: [
            CustomAppBarScreens(
              title: title,
            ),
          ],
        ),
      ],
    )));
  }
}
