import 'package:absher/presentation/widgets/custom_app_background.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAppBackGround(
        showUpperHand: true,
        child: Container(

        ),
      ),
    );
  }
}


