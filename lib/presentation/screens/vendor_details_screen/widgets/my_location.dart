import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/utils/app_router.dart';
import '../cached_image.dart';
import 'MapScreen.dart';

class MyLocation extends StatelessWidget {
  final double? latitude;
  final double? longtitude;

  const MyLocation({Key? key, required this.latitude, required this.longtitude,}) : super(key: key);

  Set<Marker> marker(double x, double y) {
    return {
      Marker(
        markerId: const MarkerId("1"),
        infoWindow: const InfoWindow(title: "peaklink"),
        position: LatLng(x, y),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child:  InkWell(
        onTap: (){
          AppRouter.navigateTo(context: context, destination:
          MapScreen(
            lat:latitude ?? 0,
            lng:longtitude ?? 0,));
        },
        child: SizedBox(
          height: 134,
          child: Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12),),),
            child: CachedImage(
              imageUrl: 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longtitude&markers=color:red%7C$latitude,$longtitude&zoom=12&size=500x500&key=AIzaSyCPsxZeXKcSYK1XXw0O0RbrZiI_Ekou5DY',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
