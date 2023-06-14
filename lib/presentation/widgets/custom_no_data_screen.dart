import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../resources/assets_manager.dart';

class CustomNoDataScreen extends StatelessWidget {
  const CustomNoDataScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(IconsManager.iconNoResult));
  }
}
