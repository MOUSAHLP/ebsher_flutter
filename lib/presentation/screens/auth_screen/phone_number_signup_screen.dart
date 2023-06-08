import 'package:absher/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:absher/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:absher/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/core/services/services_locator.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/auth_screen/otp_confirmation_screen.dart';
import 'package:absher/presentation/screens/auth_screen/widgets/phone_number_screen_background.dart';
import 'package:absher/presentation/widgets/custom_button.dart';
import 'package:absher/presentation/widgets/custom_input_field.dart';
import 'package:absher/presentation/widgets/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../translations.dart';
import '../../widgets/dialogs/loading_dialog.dart';

class PhoneNumberSignUpScreen extends StatelessWidget {
  const PhoneNumberSignUpScreen({Key? key, required this.resetPassword})
      : super(key: key);
  final bool resetPassword;
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
          if (state is SignUpOtpRequested) {
            AppRouter.pushReplacement(
                context,
                OtpConfirmationScreen(
                  resetPassword: resetPassword,
                ));
          }
        },
        child: _PhoneNumberSignUpScreenContent(
          resetPassword: resetPassword,
        ));
  }
}

class _PhoneNumberSignUpScreenContent extends StatelessWidget {
  _PhoneNumberSignUpScreenContent({Key? key, required this.resetPassword})
      : super(key: key);
  final TextEditingController textEditingController = TextEditingController();
  final bool resetPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const PhoneNumberScreenBackGround(),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 350,
              ),
              Text(
               AppLocalizations.of(context)!.enterPhone,
                style: getBoldStyle(
                  color: Colors.white,
                  fontSize: FontSizeApp.s22,
                ),
              ),
              Text(
                resetPassword
                    ?  AppLocalizations.of(context)!.phoneForPassword
                    :  AppLocalizations.of(context)!.phoneForCreat,
                textAlign: TextAlign.center,
                style: getBoldStyle(
                  color: ColorManager.softYellow,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 32,
                ),
                child: CustomInputField(
                  controller: textEditingController,
                  keyboardType: TextInputType.phone,
                  hintText: AppLocalizations.of(context)!.addNumber,
                  icon: Icons.phone_android,
                ),
              ),
              CustomButton(
                label:AppLocalizations.of(context)!.send,
                onTap: () {
                  if (resetPassword) {
                    sl<SignUpBloc>().add(ForgetPassword(
                        phoneNumber: textEditingController.text));
                  } else {
                    sl<SignUpBloc>().add(
                        RequestOtp(phoneNumber: textEditingController.text));
                  }
                },
              )
            ],
          ),
        ),
      ],
    ));
  }
}
