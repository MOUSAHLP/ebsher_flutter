import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:absher/presentation/widgets/custom_app_background.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  void navigate(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    navigate(context);
    return Scaffold(
      body: CustomAppBackGround(
        showUpperHand: true,
        child: Center(
          child: Image.asset(
            ImageManager.fullAppLogo,
            height: 180,
          ),
        ),
      ),
    );
  }
}
