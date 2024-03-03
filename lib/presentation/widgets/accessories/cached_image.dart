import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum ImageSize { large, mid, small }

class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit? fit;
  final double? height;
  final double? placeHolderHeight;
  final double? width;
  final int? cacheWidth;
  final int? cacheHeight;
  final Color? color;
  final String? fallbackPlaceHolder;
  final bool removeOnDispose;
  final ImageSize imageSize;
 final bool? isCircle;

  const CachedImage({
    Key? key,
    required this.imageUrl,
    this.fit,
    this.height,
    this.placeHolderHeight,
    this.width,
    this.cacheHeight,
    this.cacheWidth,
    this.color,
    this.fallbackPlaceHolder,
    this.removeOnDispose = true,
    this.isCircle = false,
    this.imageSize = ImageSize.large,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      imageUrl ?? '',
      fit: fit ?? BoxFit.cover,
      height: height,
      width: width,
      color: color,
      printError: false,
      cacheMaxAge: const Duration(days: 30),
      clearMemoryCacheWhenDispose: removeOnDispose,
      handleLoadingProgress: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return  isCircle==true?Shimmer.fromColors(
              baseColor: const Color(0xFFd3d7de),
              highlightColor: const Color(0xFFe2e4e9),
              child: Card(
                elevation: 0.0,
                color: const Color.fromRGBO(45, 45, 45, 1.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: const SizedBox(
                ),
              ),
            ):Shimmer.fromColors(
        baseColor: const Color(0xFFd3d7de),
        highlightColor: const Color(0xFFe2e4e9),
        child:
        const Card(),
        );
          case LoadState.completed:
            return state.completedWidget;
          case LoadState.failed:
            return ExtendedImage(
              image: AssetImage(
                fallbackPlaceHolder ?? getPlaceHolderSize(),
              ),
              clearMemoryCacheWhenDispose: true,
              fit: imageSize == ImageSize.small ? BoxFit.contain : BoxFit.cover,
              color: color,
            );
        }
      },
    );
  }

  String getPlaceHolderSize() {
    switch (imageSize) {
      case ImageSize.large:
        return ImageManager.largePlaceholder;
      case ImageSize.mid:
        return ImageManager.midPlaceholder;
      case ImageSize.small:
        return ImageManager.appLogo;
    }
  }
}
