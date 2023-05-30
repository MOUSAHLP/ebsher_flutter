import 'package:absher/presentation/widgets/custom_app_bar_screens.dart';
import 'package:flutter/material.dart';
import '../../../../translations.dart';
import '../../widgets/custom_app_background.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBackGround(
        child: SafeArea(
            child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
            ],
          ),
        ),
        Stack(
          children: [
            CustomAppBarScreens(
              title: 'Pizza',
            )
          ],
        ),
      ],
    )));
  }
}
