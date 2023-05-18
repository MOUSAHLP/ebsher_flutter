import 'package:absher/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/font_app.dart';
import '../../resources/style_app.dart';
import '../custom_button.dart';
import 'custom_dialog.dart';

class WillPopScopeHandler {
  static Future<bool> handle(BuildContext context) async {
    openDialog(context);
    return false;
  }

  static void openDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            icon: Icons.exit_to_app_rounded,
            content: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 60,
                  ),
                  child: Text(
                    "سوف يتم أغلاق أبشر, هل انت متأكد؟",
                    style: getBoldStyle(
                      color: Colors.black,
                      fontSize: FontSizeApp.s14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          label: 'البقاء',
                          fillColor: ColorManager.softYellow,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: CustomButton(
                          label: 'خروج',
                          fillColor: Colors.redAccent,
                          onTap: () {
                            SystemNavigator.pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
