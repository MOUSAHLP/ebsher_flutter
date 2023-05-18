import 'package:flutter/material.dart';

import '../../resources/font_app.dart';
import '../../resources/style_app.dart';
import '../custom_button.dart';
import 'custom_dialog.dart';

class ErrorDialog {
  static void openDialog(BuildContext context, String? message) {
    if (message == null || message.isEmpty) {}
    showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            content: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 60,
                  ),
                  child: Text(
                    (message == null || message.isEmpty)
                        ? 'حدث خطأ ما الرجاء المحاولة لاحقا'
                        : message,
                    style: getBoldStyle(
                      color: Colors.black,
                      fontSize: FontSizeApp.s14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomButton(
                    label: 'Close',
                    fillColor: Colors.redAccent,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
