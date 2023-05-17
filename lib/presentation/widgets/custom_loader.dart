import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDialog {
  static final LoadingDialog _loadingDialog = LoadingDialog._internal();

  factory LoadingDialog() {
    return _loadingDialog;
  }

  LoadingDialog._internal();

  bool _isShown = false;

  void closeDialog(BuildContext context) {
    if (_isShown) {
      Navigator.of(context).pop();
      _isShown = false;
    }
  }

  void openDialog(BuildContext context) {
    _isShown = true;
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (_, __, ___) {
        return CustomLoader();
      },
    ).whenComplete(() => _isShown = false);
  }
}

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(28)),
            color: ColorManager.primaryColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitThreeInOut(
                itemBuilder: (_, int index) {
                  return ImageIcon(
                    AssetImage(
                      ImageManager.appLogo,
                    ),
                    size: 40,
                    color: Colors.white,
                  );
                },
              ),
              Text(
                'جاري المعالجة',
                style: TextStyle(
                  // fontFamily: appFontFamily,
                  fontSize: 16,
                  decoration: TextDecoration.none, ////set decoration to .none
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  // fontWeight: FontWeight.bold,
                  // fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
