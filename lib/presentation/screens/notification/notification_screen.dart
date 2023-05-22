import 'package:absher/presentation/resources/style_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/values_app.dart';
import '../../widgets/custom_app_background.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBackGround(
        child: SafeArea(
            child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: PaddingApp.p22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                height: 37,
                width: 36,
                child: Icon(Icons.arrow_back),
              ),
              Text("الاشعارات",style: getBoldStyle(color: Colors.white,fontSize: 18)),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                height: 37,
                width: 36,
                child: Icon(Icons.share),
              ),
            ],
          ),
        ),
        Container(),
      ],
    )));
  }
}
