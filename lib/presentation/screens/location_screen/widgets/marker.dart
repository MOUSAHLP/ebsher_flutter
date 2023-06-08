import 'package:absher/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
class MarkerWidget extends StatelessWidget {
  String image;

  MarkerWidget( {super.key,required this.image,});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Icon(
          Icons.add_location,
          color: ColorManager.lightBlueColor,
          size: 50,
        ),
        Positioned(
          left: 15,
          top: 8,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Center(child: ClipRRect(
                borderRadius: BorderRadius.circular(50),child: Image.network(image))),
          ),
        )
      ],
    );
  }
}
