import 'package:absher/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:absher/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:absher/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/core/services/services_locator.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/auth_screen/forget_password_screen.dart';
import 'package:absher/presentation/screens/auth_screen/sign_up_screen.dart';
import 'package:absher/presentation/screens/auth_screen/widgets/otp_screen_background.dart';
import 'package:absher/presentation/widgets/custom_button.dart';
import 'package:absher/presentation/widgets/dialogs/error_dialog.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../widgets/dialogs/loading_dialog.dart';
import '../location_screen/widgets/app_bar_widget.dart';

class OtpConfirmationScreen extends StatelessWidget {
  const OtpConfirmationScreen({Key? key, required this.resetPassword})
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
            ErrorDialog.openDialog(context, state.error);
          }
          if (state is SignUpOtpConfirmed) {
            resetPassword
                ? AppRouter.pushReplacement(
                    context, const ForgetPasswordScreen())
                : AppRouter.pushReplacement(context, SignUpScreen());
          }
        },
        child: _OtpConfirmationScreenContent(
          resetPassword: resetPassword,
        ));
  }
}

class _OtpConfirmationScreenContent extends StatelessWidget {
  _OtpConfirmationScreenContent({Key? key, required this.resetPassword})
      : super(key: key);
  final TextEditingController textEditingController = TextEditingController();
  final bool resetPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const OtpScreenBackground(),
        SingleChildScrollView(
          child: Column(
            children: [
               SizedBox(
                height: 1.sh-350,
              ),
              SizedBox(
                height: 350,
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.sendCode,
                      style: getBoldStyle(
                        color: Colors.white,
                        fontSize: FontSizeApp.s22,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                        !resetPassword
                            ? AppLocalizations.of(context)!.verifyMobileCreat(
                            encodePhoneNumber(context
                                .read<SignUpBloc>()
                                .otpVerifyResponse
                                ?.phone))
                            : AppLocalizations.of(context)!.verifyMobilePassword(
                            encodePhoneNumber(context
                                .read<SignUpBloc>()
                                .otpVerifyResponse
                                ?.phone)),
                        textAlign: TextAlign.center,
                        style: getBoldStyle(
                          color: ColorManager.softYellow,
                        ),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.yourCode(context
                          .read<SignUpBloc>()
                          .otpVerifyResponse
                          ?.code as Object),
//                'Your Code is ${context.read<SignUpBloc>().otpVerifyResponse?.code}',
                      textAlign: TextAlign.center,
                      style: getBoldStyle(
                        color: ColorManager.softYellow,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: PinFieldAutoFill(
                        decoration: UnderlineDecoration(
                          textStyle:
                          const TextStyle(fontSize: 20, color: Colors.white),
                          colorBuilder: const FixedColorBuilder(Colors.white),
                        ),
                        currentCode: textEditingController.text,
                        codeLength: 6,
                        onCodeChanged: (String? code) {

                          if (code != null) {

                            textEditingController.text = code;
                            if (code.length == 6) {
                              sl<SignUpBloc>()
                                  .add(ConfirmOtp(code: textEditingController.text));
                            }
                          }
                        },
                      ),
                    ),
                    CustomButton(
                      label: AppLocalizations.of(context)!.send,
                      onTap: () {
                        if (textEditingController.text.length == 6) {
                          sl<SignUpBloc>()
                              .add(ConfirmOtp(code: textEditingController.text));
                        } else {
                          toast("ادخال كافة الحقول");
                        }
                      },
                    )
                  ],
                ),
              )

            ],
          ),
        ),
   const  AppBarWidget()
      ],
    ));
  }

  String encodePhoneNumber(String? phone) {
    if (phone == null || phone.length < 3) return '***';
    return ' ${phone.substring(phone.length - 2)} ***';
  }
}
