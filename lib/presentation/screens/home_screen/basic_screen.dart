import 'package:absher/bloc/bottom_bloc/bottom_event.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:absher/presentation/widgets/custom_app_bottom_navigation.dart';
import 'package:absher/presentation/widgets/dialogs/will_pop_scope_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/bottom_bloc/bottom_bloc.dart';
import '../../../bloc/bottom_bloc/bottom_state.dart';

import '../../../core/services/services_locator.dart';
import '../../widgets/custom_app_drawer.dart';
import '../favorites_screen/favorites_screen.dart';
import '../reels_screen/reels_screen.dart';
import 'home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../resources/assets_manager.dart';
import '../../widgets/custom_app_background.dart';
import '../../widgets/custom_app_bar.dart';

class BasicScreen extends StatelessWidget {
  BasicScreen({super.key});

  static final List<Widget> _screenOptions = <Widget>[
    HomeScreen(),
    const FavoritesScreen(),
    Container(
      height: 500,
      color: Colors.yellow,
    ),
    Container(),
    EditProfileScreen(),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBloc, BottomState>(builder: (context, state) {
      if (state is NewButtom) {
        return WillPopScope(
          onWillPop: () async {
            if (_scaffoldKey.currentState?.isDrawerOpen == true) {
              _scaffoldKey.currentState?.closeDrawer();
            } else {
              if (state.index == 0) {
                WillPopScopeHandler.handle(context);
              } else {
                context.read<BottomBloc>().add(NewBottomChange(0));
              }
            }
            return false;
          },
          child: Scaffold(
            key: _scaffoldKey,
            drawerEnableOpenDragGesture: true,
            backgroundColor: ColorManager.backgroundStartColor,
            body: CustomAppBackGround(
              child: SafeArea(
                child: Column(
                  children: [
                    CustomAppBar(
                      _scaffoldKey,
                    ),
                    _screenOptions[state.index],
                    const CustomAppBottomNavigation(),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: ColorManager.whiteColor,
                onPressed: () {
                  sl<BottomBloc>().add(NewBottomChange(0));
                },
                child: SvgPicture.asset(
                  IconsManager.iconHome,
                  color: state.index == 0
                      ? ColorManager.softYellow
                      : ColorManager.lightBlueColor,
                )),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            drawer:  CustomAppDrawer(),
          ),
        );
      } else
        return Text("");
    });
  }
}
