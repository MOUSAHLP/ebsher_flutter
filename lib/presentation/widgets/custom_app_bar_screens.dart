import 'package:absher/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../core/app_router/app_router.dart';
import '../resources/style_app.dart';
import '../resources/values_app.dart';
// ignore: must_be_immutable
class CustomAppBarScreens extends StatelessWidget {
  String title;

  CustomAppBarScreens({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return   Container(
      color: ColorManager.backgroundEndColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: PaddingApp.p16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              height: 40,
              width: 40,
              child: const Icon(Icons.share),
            ),
            Text(title,
                style: getBoldStyle(color: Colors.white, fontSize: 18)),
            GestureDetector(
              onTap: () {
                AppRouter.pop(context);
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                height: 40,
                width: 40,
                child:  Icon(Icons.arrow_forward,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
