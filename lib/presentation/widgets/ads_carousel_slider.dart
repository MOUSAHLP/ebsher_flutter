import 'package:absher/models/advertisement_response.dart';
import 'package:absher/presentation/resources/values_app.dart';
import 'package:absher/presentation/widgets/accessories/cached_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdsCarouselSlider extends StatefulWidget {
  const AdsCarouselSlider({Key? key, required this.ads}) : super(key: key);
  final List<AdvertisementsResponse> ads;

  @override
  State<AdsCarouselSlider> createState() => _AdsCarouselSliderState();
}

class _AdsCarouselSliderState extends State<AdsCarouselSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            enlargeCenterPage: true,
            autoPlay: true,
            height: 15.2.h,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          items: widget.ads.map((ad) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: SizeApp.s16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(RadiusApp.r27),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(RadiusApp.r27),
                    child: CachedImage(
                      imageUrl: ad.photo,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 2.1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < widget.ads.length; i++)
              currentIndex == i
                  ? Container(
                      height: 1.1.h,
                      width: 1.1.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    )
                  : Container(
                      height: 1.1.h,
                      width: 1.1.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        shape: BoxShape.circle,
                      ),
                    )
          ],
        ),
      ],
    );
  }
}
