import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/widgets/accessories/cached_image.dart';
import 'package:absher/translations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/vendor_model.dart';

class CustomDilog extends StatefulWidget {
  final VendorModel photosUrls;

  CustomDilog({super.key, required this.photosUrls});

  @override
  State<CustomDilog> createState() => _CustomDilogState();
}

class _CustomDilogState extends State<CustomDilog> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.photosUrls.images!.isEmpty) return Center(child: Text(AppLocalizations.of(context)!.noThing,style: getBoldStyle(color: Colors.white),));
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
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },),
          items: List.generate(widget.photosUrls.images!.length, (index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(21),
              child: CachedImage(imageUrl:widget.photosUrls.images![index].image),
            );
          }),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < widget.photosUrls.images!.length; i++)
              currentIndex == i
                  ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 0.5.h,
                  width: 3.1.h,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                  ),
                ),
              )
                  : Container(
                height: 0.5.h,
                width: 3.1.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  shape: BoxShape.rectangle,
                ),
              )
          ],
        ),
      ],
    );
  }
}
