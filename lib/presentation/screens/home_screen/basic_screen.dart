import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/widgets/custom_app_bottom_navigation.dart';
import 'package:absher/presentation/widgets/dialogs/will_pop_scope_handler.dart';
import '../../widgets/custom_app_drawer.dart';
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
    Container(),
    Container(),
    Container(),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()  async{
        if(_scaffoldKey.currentState?.isDrawerOpen==true){
          _scaffoldKey.currentState?.closeDrawer();
        }else
       { WillPopScopeHandler.handle(context);}

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
                CustomAppBar(_scaffoldKey,),
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
        drawer:const CustomAppDrawer(),
      ),
    );
  }

}
