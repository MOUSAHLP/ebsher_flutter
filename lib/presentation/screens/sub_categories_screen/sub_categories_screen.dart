import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/models/advertisement_response.dart';
import 'package:absher/presentation/screens/sub_categories_screen/widgets/card_sub_category.dart';
import 'package:absher/presentation/widgets/custom_app_bar_screens.dart';
import 'package:flutter/material.dart';
import '../../../core/localization_string.dart';
import '../../resources/assets_manager.dart';
import '../../widgets/ads_carousel_slider.dart';
import '../../widgets/custom_app_background.dart';
import '../vendors_screen/vendors_screen.dart';

class SubCategoriesScreen extends StatelessWidget {
  String title;
  int id;

   SubCategoriesScreen({super.key,required this.title,required this.id});

  @override
  Widget build(BuildContext context) {
    return CustomAppBackGround(
        child: SafeArea(
            child: Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 60),
            AdsCarouselSlider(
              ads: [AdvertisementsResponse(photo: ImageManager.test)],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SizedBox(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: (){
                          AppRouter.push(
                              context,
                                 VendorsScreen(
                    title:
                        title,
                    categoryId: id),
                          );
                        },
                        child: CardSubCategory());
                  },
                ),
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
        Stack(
          children: [
            CustomAppBarScreens(
              title: title,
            )
          ],
        ),
      ],
    )));
  }
}
