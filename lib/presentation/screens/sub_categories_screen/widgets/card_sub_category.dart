import 'package:absher/presentation/widgets/accessories/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/style_app.dart';

// ignore: must_be_immutable
class CardSubCategory extends StatelessWidget {
  String title;
  String image;

  CardSubCategory({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    var size = (1.sw - 40) * 98;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Stack(
        children: [
          Container(
            width: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            height: size / 338,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedImage(
                imageUrl: image,
                fit: BoxFit.cover,
                imageSize: ImageSize.mid,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.transparent,
                  ],
                ),
                border: Border.all(color: Colors.white, width: 2)),
            height: size / 338,
            child: Center(
                child: Text(title,
                    style: getBoldStyle(color: Colors.white, fontSize: 27))),
          ),
        ],
      ),
    );
  }
}
