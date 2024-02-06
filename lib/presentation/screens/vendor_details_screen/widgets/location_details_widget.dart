import 'package:flutter/material.dart';
import 'my_location.dart';

class LocationDetailsWidget extends StatelessWidget {
  final double? latitude;
  final double? longitude;
  final String? address;
  const LocationDetailsWidget({Key? key,required this.address,required this.longitude,required this.latitude}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            width: double.infinity,
            decoration: const BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
          child:Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height:8,),
              if(latitude!=null&&longitude!=null)
              SizedBox(
                  height: 150,
                  child: MyLocation(latitude:latitude??0, longtitude:longitude??0,))
        ],
      ),
    ));
  }
}
