
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/widgets/accessories/cached_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/hex_colors.dart';

// ignore: must_be_immutable
class MarkerWidget extends StatelessWidget {
  String image;
  String colors;

  MarkerWidget({super.key, required this.image, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(
          Icons.add_location,
        color: colors=="null"||colors.isEmpty?ColorManager.primaryColor:HexColor.fromHex(colors),
          size: 50,
        ),
        Positioned(
          left: 15,
          top: 8,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:colors=="null"||colors.isEmpty?ColorManager.primaryColor:HexColor.fromHex(colors)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child:  CachedImage(
                imageUrl: image=="null"||image.isEmpty?"":image,
              ),
            ),
          ),
        )
      ],
    );
  }
}

