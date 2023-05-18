import 'package:flutter/material.dart';

import '../../resources/font_app.dart';
import '../../resources/style_app.dart';
import '../custom_button.dart';

class ErrorDialog {
  static void openDialog(BuildContext context, String? message) {
    if (message == null || message.isEmpty) {}
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        // height: 240,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          color: Colors.white,
                        ),
                        child: Column(
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
                      ),
                      Positioned(
                        top: -30,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
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
