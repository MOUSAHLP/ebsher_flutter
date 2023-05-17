import 'package:absher/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:absher/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:absher/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:absher/core/services/services_locator.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/auth_screen/sign_up_screen.dart';
import 'package:absher/presentation/widgets/custom_app_background.dart';
import 'package:absher/presentation/widgets/custom_button.dart';
import 'package:absher/presentation/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../widgets/custom_loader.dart';

class OtpConfirmationScreen extends StatelessWidget {
  const OtpConfirmationScreen({Key? key}) : super(key: key);

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
            toast('error');
          }
          if (state is SignUpOtpConfirmed) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => SignUpScreen(),
              ),
            );
          }
        },
        child: _OtpConfirmationScreenContent());
  }
}

class _OtpConfirmationScreenContent extends StatelessWidget {
  _OtpConfirmationScreenContent({Key? key}) : super(key: key);
  final TextEditingController textEditingController = TextEditingController();
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
                'لقد أرسلنا الرمز إلى هاتفك',
                style: getBoldStyle(
                  color: Colors.white,
                  fontSize: FontSizeApp.s22,
                ),
              ),
              Text(
                'يرجى التحقق من رقم هاتفك المحمول 071 ***** 12 استمر في إعادة تعيين كلمة المرور الخاصة بك',
                textAlign: TextAlign.center,
                style: getBoldStyle(
                  color: ColorManager.softYellow,
                ),
              ),
              Text(
                'Your Code is ${context.read<SignUpBloc>().otpVerifyResponse?.code}',
                textAlign: TextAlign.center,
                style: getBoldStyle(
                  color: ColorManager.softYellow,
                ),
              ),
              Container(
                  child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: PinFieldAutoFill(
                  decoration: UnderlineDecoration(
                    textStyle: TextStyle(fontSize: 20, color: Colors.white),
                    colorBuilder: FixedColorBuilder(Colors.white),
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
              )),
              CustomButton(
                label: 'أرسال',
                onTap: () {
                  sl<SignUpBloc>()
                      .add(ConfirmOtp(code: textEditingController.text));
                },
              )
            ],
          ),
        ),
      ],
    ));
  }
}

class PhoneNumberScreenBackGround extends StatelessWidget {
  const PhoneNumberScreenBackGround({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomAppBackGround(
          child: SizedBox(),
        ),
        Stack(
          children: [
            Positioned(
              top: -50,
              right: -60,
              child: Container(
                width: 280,
                height: 280,
                decoration: const BoxDecoration(
                  color: ColorManager.softYellow,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      color: ColorManager.shadowGrey,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: -70,
              right: -50,
              child: Image.asset(
                ImageManager.otpAsset,
                width: 280,
              ),
            ),
            Positioned(
              top: -60,
              left: -55,
              child: Container(
                width: 280,
                height: 280,
                decoration: const BoxDecoration(
                  color: ColorManager.softYellow,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      color: ColorManager.shadowGrey,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: -80,
              left: -60,
              child: Image.asset(
                ImageManager.otpAsset2,
                width: 280,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
