import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

ImageProvider cachedImageProvider(
  String? url,
) {
  try {
    if (url == null) {
      return const AssetImage(ImageManager.test1);
    } else {
      return ExtendedNetworkImageProvider(
        url,
        cache: true,
        cacheMaxAge: const Duration(days: 30),
        printError: false,
      );
    }
  } catch (error) {
    return const AssetImage(ImageManager.midPlaceholder);
  }
}
