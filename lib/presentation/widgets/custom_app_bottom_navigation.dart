import 'package:absher/bloc/bottom_bloc/bottom_state.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bottom_bloc/bottom_bloc.dart';
import '../../bloc/bottom_bloc/bottom_event.dart';
import '../../core/services/services_locator.dart';
import '../resources/values_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../screens/location_screen/location_screen.dart';
import '../screens/reels_screen/reels_screen.dart';

class CustomAppBottomNavigation extends StatelessWidget {
  const CustomAppBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBloc, BottomState>(
        bloc:  sl<BottomBloc>()..add(NewBottomChange(0)),
        builder: (context, state) {
          if(state is NewButtom)
       { return Container(
          height: SizeApp.s50,
          decoration: const BoxDecoration(
            color: ColorManager.lightWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(RadiusApp.r20),
              topRight: Radius.circular(RadiusApp.r20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: IconBottomNavigation(imag:IconsManager.iconStars, onTap:(){
                  sl<BottomBloc>().add(NewBottomChange(1));
                },color:state.index==1? ColorManager.softYellow: ColorManager.lightBlueColor),
              ),

              Expanded(
                child: IconBottomNavigation(imag:  IconsManager.iconSearch, onTap:(){
                  AppRouter.push(context, const LocationScreen());
                } ,color:state.index==2? ColorManager.softYellow: ColorManager.lightBlueColor),
              ),
              
              const Expanded(child: SizedBox(width: SizeApp.s5)),
             
              Expanded(
                child: IconBottomNavigation(imag:  IconsManager.iconVideo, onTap:(){
                  AppRouter.push(context, const ReelsScreen());
                },color: state.index==3?ColorManager.softYellow: ColorManager.lightBlueColor),
              ),
              
              Expanded(
                child: IconBottomNavigation(imag:  IconsManager.iconUser, onTap:(){
                  sl<BottomBloc>().add(NewBottomChange(4));
                },color: state.index==4? ColorManager.softYellow: ColorManager.lightBlueColor ),
              ),
            ],
          ),
        );}
          else {
            return const Text("");
          }
    });
  }
}

// ignore: must_be_immutable
class IconBottomNavigation  extends StatelessWidget {
  String imag;
  Function onTap;
  Color color;
  IconBottomNavigation({super.key, required this.imag,required this.onTap,required this.color});
  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: () {
      onTap();
      },
      child: SvgPicture.asset(
        imag,
        color:color ,
      ),
    );
  }
}

