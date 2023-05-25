import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/widgets/custom_cach_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization_string.dart';
import '../../../../models/sub_category_response.dart';
import '../../../resources/assets_manager.dart';

class cardRandomWidget extends StatelessWidget {
  SubCategoriesResponse categories;

  cardRandomWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    List<Widget> card = [
      CircularCard(image: categories.logo!),
      RectangleCard(image: categories.logo!),
      RectangleRotationCard(image: categories.logo!)
    ];
    card.shuffle();
    return Padding(
      padding: const EdgeInsets.only(right: 40, bottom: 20, left: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 400,
            height: 100,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(50),
                  bottomEnd: Radius.circular(50),
                  topStart: Radius.circular(10),
                  bottomStart: Radius.circular(10),
                )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocalixationString(context, categories.name) ?? "",
                    style: getBoldStyle(
                        color: ColorManager.backgroundEndColor, fontSize: 16),
                  ),

                  Text(
                    LocalixationString(context, categories.description) ?? "",
                    style: getBoldStyle(color: Colors.black, fontSize: 14),
                  ),
                  Row(
                    children: [
                      Text(
                        categories.address ?? "",
                        style: getBoldStyle(color: Colors.black, fontSize: 14),
                      ),
                      const SizedBox(width: 30,),
                      Text(
                        categories.isOpen==true ? "Open":"Close",
                        style: getBoldStyle(color: Colors.red, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned.directional(
              top: 10,
              end: -15,
              textDirection: Directionality.of(context),
              child: card[2])
        ],
      ),
    );
  }
}

class CircularCard extends StatelessWidget {
  String image;

  CircularCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,boxShadow:ColorManager.boxShadow, ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CustomCachImage(width:70 ,height:70 ,url:image ,)

      ),
    );
  }
}

class RectangleCard extends StatelessWidget {
  String image;

  RectangleCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.circular(10), shape: BoxShape.rectangle,boxShadow:ColorManager.boxShadow,),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child:  CustomCachImage(width:70 ,height:70 ,url:image ,)
      ),
    );
  }
}

class RectangleRotationCard extends StatelessWidget {
  String image;

  RectangleRotationCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 40,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.fitHeight,
            ),
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
          boxShadow:ColorManager.boxShadow,),
      ),
    );
  }
}
