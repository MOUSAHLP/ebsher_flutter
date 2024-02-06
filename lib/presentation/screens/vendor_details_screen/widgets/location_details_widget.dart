import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'my_location.dart';

class LocationDetailsWidget extends StatelessWidget {
  final double? latitude;
  final double? longitude;

  const LocationDetailsWidget({Key? key,required this.longitude,required this.latitude}) : super(key: key);

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
              Row(
                children: [
                  SvgPicture.asset(IconsManager.iconLocation,color: ColorManager.softYellow),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    AppLocalizations.of(context)!.location_vendor,
                    style: getRegularStyle(
                      color: ColorManager.primaryColor,
                      fontSize: FontSizeApp.s12,
                    ),
                  ),
                ],
              ),
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
