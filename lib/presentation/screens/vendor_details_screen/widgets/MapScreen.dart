import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
 const MapScreen({required this.lat, required this.lng, Key? key}) : super(key: key);
  final double lat, lng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: SizedBox(
          // height: 100.h,
          // width: 100.w,
          child: GoogleMap(
            mapType: MapType.normal,
            markers: {
              Marker(
                  markerId: const MarkerId('0'),
                  position: LatLng(
                    lat,
                    lng
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
              ),
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  lat,
                  lng),
              zoom: 12.2746,
            ),
            onMapCreated: (GoogleMapController controller) {},
          ),
        ),
      ),
    );
  }
}