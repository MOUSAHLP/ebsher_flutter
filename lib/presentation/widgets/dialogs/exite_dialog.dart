import 'package:absher/bloc/authentication_bloc/authentication_event.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/core/app_router/dialog_transition_builder.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/screens/auth_screen/account_screen.dart';
import 'package:flutter/material.dart';
import '../../../bloc/authentication_bloc/authertication_bloc.dart';
import '../../../core/services/services_locator.dart';
import '../../resources/font_app.dart';
import '../../resources/style_app.dart';
import '../custom_button.dart';
import 'custom_dialog.dart';

class ExiteDialog {
  static Future<bool> handle(BuildContext context) async {
    dialogTransitionBuilder(context, const _ExitAppDialog());
    return false;
  }
}

class _ExitAppDialog extends StatelessWidget {
  const _ExitAppDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              "سوف يتم الخروج من  أبشر, هل انت متأكد؟",
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
                      AppRouter.pop(context);
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
                      sl<AuthenticationBloc>().add(LoggedOut());
                    AppRouter.pushAndRemoveAllStack(context, AccountScreen());

                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
