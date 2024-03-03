import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/widgets/accessories/cached_image.dart';
import 'package:absher/translations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../../models/vendor_model.dart';

class CustomDilog extends StatelessWidget {
  final VendorModel photosUrls;

  const CustomDilog({super.key, required this.photosUrls});

  @override
  Widget build(BuildContext context) {
    // if (photosUrls.images!.isEmpty) return Center(child: Text(AppLocalizations.of(context)!.noThing,style: getBoldStyle(color: Colors.white),));
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          options: CarouselOptions(
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              enlargeFactor: 0,
              viewportFraction: 1.0,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {}),
          items: List.generate(photosUrls.images!.length, (index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(21),
              child: CachedImage(imageUrl:photosUrls.images![index].image),
            );
          }),
        ),
      ],
    );
  }
}
