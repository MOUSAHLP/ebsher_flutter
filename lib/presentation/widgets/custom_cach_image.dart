import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

class CustomCachImage extends StatelessWidget {
  const CustomCachImage(
      {required this.url,required this.width ,required this.height, super.key});

  final String? url;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      url!,
      width: width,
      height: height,
      fit: BoxFit.fill,
      cache: true,
      clearMemoryCacheWhenDispose: true,
//      cacheWidth: int.parse(width.toString()),
//      cacheHeight: int.parse(height.toString()),
      cacheMaxAge: Duration(days: 2),

      borderRadius: BorderRadius.all(Radius.circular(30.0)),
        loadStateChanged: (ExtendedImageState state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              {
                return Icon(Icons.photo, color: Colors.teal.shade100,);
              }
            case LoadState.failed:
              {
                return Icon(Icons.photo, color: Colors.teal.shade100,);
              }
          }
        }


    );
  }
}
