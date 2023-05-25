import 'package:absher/bloc/login_bloc/login_event.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/models/params/login_params.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/auth_screen/phone_number_signup_screen.dart';
import 'package:absher/presentation/screens/auth_screen/widgets/login_screen_background.dart';
import 'package:absher/presentation/screens/home_screen/basic_screen.dart';
import 'package:absher/presentation/widgets/custom_input_field.dart';
import 'package:absher/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:absher/presentation/widgets/custom_password_input_field.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/login_bloc/login_bloc.dart';
import '../../../bloc/login_bloc/login_state.dart';
import '../../../core/services/services_locator.dart';
import '../../resources/color_manager.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/dialogs/error_dialog.dart';

class SignInConfirmationScreen extends StatelessWidget {
  const SignInConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            LoadingDialog().openDialog(context);
          } else {
            LoadingDialog().closeDialog(context);
          }
          if (state is LoginError) {
            ErrorDialog.openDialog(context, state.error);
          }
          if (state is LoginConfirmed) {
            AppRouter.pushAndRemoveAllStack(context,  BasicScreen());
          }
        },
        child: _SignInScreen());
  }
}

class _SignInScreen extends StatelessWidget {
  _SignInScreen({Key? key}) : super(key: key);
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const LoginScreenBackGround(),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 400,
                ),
                CustomInputField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  hintText: 'أضف رقمك',
                  withLabel: true,
                  icon: Icons.phone_android,
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomPasswordInputField(
                  controller: passwordController,
                  hintText: AppLocalizations.of(context)!.password,
                  withLabel: true,
                  icon: Icons.lock_open_rounded,
                ),
                GestureDetector(
                  onTap: () {
                    AppRouter.pushReplacement(
                        context,
                        const PhoneNumberSignUpScreen(
                          resetPassword: true,
                        ));
                  },
                  child: Text(
                    'هل نسيت كلمة المرور؟',
                    style: getSemiBoldStyle(
                      color: ColorManager.softYellow,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomButton(
                    label: 'تسجيل ',
                    onTap: () {
                      sl<LoginBloc>().add(Login(
                          loginParams: LoginParams(
                              phone: phoneController.text,
                              password: passwordController.text)));
                    }),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
