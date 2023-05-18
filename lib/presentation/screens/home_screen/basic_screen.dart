import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/widgets/custom_app_bottom_navigation.dart';
import 'package:absher/presentation/widgets/dialogs/will_pop_scope_handler.dart';
import 'home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../resources/assets_manager.dart';
import '../../widgets/custom_app_background.dart';
import '../../widgets/custom_app_bar.dart';

class BasicScreen extends StatelessWidget {
  const BasicScreen({super.key});
  static final List<Widget> _screenOptions = <Widget>[
    HomeScreen(),
    Container(),
    Container(),
    Container(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => WillPopScopeHandler.handle(context),
      child: Scaffold(
        backgroundColor: ColorManager.backgroundStartColor,
        body: CustomAppBackGround(
          child: SafeArea(
            child: Column(
              children: [
                CustomAppBar(),
                _screenOptions.elementAt(0),
                const CustomAppBottomNavigation(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ColorManager.whiteColor,
            onPressed: () {},
            child: SvgPicture.asset(
              IconsManager.iconHome,
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
