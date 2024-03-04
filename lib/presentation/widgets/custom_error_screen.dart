import 'package:absher/presentation/widgets/custom_button.dart';
import 'package:absher/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../resources/assets_manager.dart';
class CustomErrorScreen extends StatelessWidget {
  final Function()? onTap;
  const CustomErrorScreen({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(IconsManager.iconNoInternet),
          const SizedBox(height: 80),
          CustomButton(label: AppLocalizations.of(context)!.tryAgain,onTap: (){
            onTap!();
          },)
        ],
      ),
    );
  }
}
