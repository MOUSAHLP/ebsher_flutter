import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/style_app.dart';
class CardSubCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size=(1.sw-40)*98;
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image:const  DecorationImage(
                image: AssetImage(ImageManager.test1),
                fit: BoxFit.cover,
              ),
            ),
            height: size/338,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient:LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.transparent,
                  ],
                ) ,
                border: Border.all(color: Colors.white, width: 2)),
            height:  size/338,
            child: Center(
                child: Text("Resturant",
                    style: getBoldStyle(color: Colors.white,fontSize: 27))),
          ),
        ],
      ),
    );
  }
}
