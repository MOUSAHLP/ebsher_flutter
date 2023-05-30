import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

class CustomAppBackGround extends StatelessWidget {
  const CustomAppBackGround({
    Key? key,
    this.showUpperHand = false,
    required this.child,
  }) : super(key: key);
  final bool showUpperHand;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color(0xFF257679),
                      Color(0xFF2C8E91),
                      Color(0xFF33A5A8),
                      Color(0xFF3ABABD),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -120,
                left: -160,
                child: Image.asset(
                  ImageManager.appLogo,
                  color: Colors.white.withOpacity(0.3),
                  width: 340,
                ),
              ),
              if (showUpperHand)
                Positioned(
                  top: -120,
                  right: -200,
                  child: Image.asset(
                    ImageManager.appLogo,
                    color: Colors.white.withOpacity(0.3),
                    width: 340,
                  ),
                ),
            ],
          ),
          child
        ],
      ),
    );
  }
}
