import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/widgets/custom_app_background.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAppBackGround(
        showUpperHand: true,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Center(
                child: Image.asset(
                  ImageManager.fullAppLogo,
                  height: 180,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.calling,
                      style: const TextStyle(
                        color: ColorManager.softYellow,
                        fontSize: 14.0,
                      ),
                    ),
                    FutureBuilder(
                      future: PackageInfo.fromPlatform(),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<PackageInfo> snapshot,
                      ) {
                        if (snapshot.hasData) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'V ${snapshot.data!.version}',
                                style: TextStyle(
                                  height: 0.8,
                                  color: ColorManager.softYellow,
                                  fontSize: 12.0,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                width: 8,
                                height: 8,
                                child: CircularProgressIndicator(
                                  color: ColorManager.softYellow,
                                  strokeWidth: 1,
                                ),
                              ),
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
