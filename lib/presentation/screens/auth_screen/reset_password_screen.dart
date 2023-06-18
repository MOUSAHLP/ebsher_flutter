import 'package:absher/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:absher/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:absher/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/core/services/services_locator.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/auth_screen/otp_confirmation_screen.dart';
import 'package:absher/presentation/screens/auth_screen/sign_in_screen.dart';
import 'package:absher/presentation/screens/auth_screen/widgets/phone_number_screen_background.dart';
import 'package:absher/presentation/screens/auth_screen/widgets/reset_password_screen_background.dart';
import 'package:absher/presentation/widgets/custom_button.dart';
import 'package:absher/presentation/widgets/custom_input_field.dart';
import 'package:absher/presentation/widgets/custom_password_input_field.dart';
import 'package:absher/presentation/widgets/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../translations.dart';
import '../../widgets/dialogs/loading_dialog.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpLoading) {
            LoadingDialog().openDialog(context);
          } else {
            LoadingDialog().closeDialog(context);
          }
          if (state is SignUpError) {
            ErrorDialog.openDialog(context, null);
          }
          if (state is ResetPasswordCompleted) {
            AppRouter.pushReplacement(context, SignInConfirmationScreen());
          }
          if(state is SignUpFieldsValidationFailed){
            toast(state.validationError!);
          }
        },
        child: _PhoneNumberSignUpScreenContent());
  }
}

class _PhoneNumberSignUpScreenContent extends StatelessWidget {
  _PhoneNumberSignUpScreenContent({Key? key}) : super(key: key);
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const ResetPasswordScreenBackground(),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                SizedBox(
                  height: 400,
                ),
                Text(
                  'تعيين كلمة المرور\n الجديدة',
                  textAlign: TextAlign.center,
                  style: getBoldStyle(
                    color: Colors.white,
                    fontSize: FontSizeApp.s22,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomPasswordInputField(
                  controller: passwordController,
                  hintText: AppLocalizations.of(context)!.password,
                  withLabel: true,
                  icon: Icons.lock_open_rounded,
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomPasswordInputField(
                  controller: repeatPasswordController,
                  hintText: "تأكيد كلمة المرور",
                  withLabel: true,
                  icon: Icons.lock_open_rounded,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomButton(
                  label: 'التالي',
                  onTap: () {
                    sl<SignUpBloc>().add(ResetPassword(
                        password: passwordController.text,
                        repeatPassword: repeatPasswordController.text));
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
