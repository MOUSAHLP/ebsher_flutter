import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

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
            return ExtendedImage(
              image: AssetImage(
                fallbackPlaceHolder ?? getPlaceHolderSize(),
              ),
              clearMemoryCacheWhenDispose: true,
              fit: imageSize == ImageSize.small ? BoxFit.contain : BoxFit.cover,
              color: color,
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
