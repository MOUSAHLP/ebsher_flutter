import 'package:absher/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_router/app_router.dart';
import '../../../resources/assets_manager.dart';
import '../../../widgets/custom_icon.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                AppRouter.pop(context);
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: ColorManager.primaryColor, shape: BoxShape.circle),
                height: 40,
                width: 40,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomIcon(
                    svgAsset: IconsManager.iconBackArrow,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
