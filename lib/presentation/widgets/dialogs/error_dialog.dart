import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/core/app_router/dialog_transition_builder.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';

import '../../resources/font_app.dart';
import '../../resources/style_app.dart';
import '../custom_button.dart';
import 'custom_dialog.dart';

class ErrorDialog {
  static void openDialog(BuildContext context, String? message) {
    dialogTransitionBuilder(
        context,
        _ErrorDialogBody(
          message: message,
        ));
  }
}

class _ErrorDialogBody extends StatelessWidget {
  const _ErrorDialogBody({Key? key, this.message}) : super(key: key);
  final String? message;
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 60,
            ),
            child: Text(
              (message == null || message!.isEmpty)
                  ? AppLocalizations.of(context)!.error
                  : message!,
              style: getBoldStyle(
                color: Colors.black,
                fontSize: FontSizeApp.s14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              label: AppLocalizations.of(context)!.close,
              fillColor: Colors.redAccent,
              onTap: () {
                AppRouter.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
