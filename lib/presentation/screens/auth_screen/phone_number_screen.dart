import 'package:absher/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:absher/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:absher/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:absher/core/services/services_locator.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/auth_screen/otp_confirmation_screen.dart';
import 'package:absher/presentation/widgets/custom_app_background.dart';
import 'package:absher/presentation/widgets/custom_button.dart';
import 'package:absher/presentation/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../widgets/custom_loader.dart';

class RequestOtpScreen extends StatelessWidget {
  const RequestOtpScreen({Key? key}) : super(key: key);

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
          if (state is SignUpOtpRequested) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => OtpConfirmationScreen(),
              ),
            );
          }
        },
        child: _RequestOtpScreenContent());
  }
}

class _RequestOtpScreenContent extends StatelessWidget {
  _RequestOtpScreenContent({Key? key}) : super(key: key);
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
                'أدخل رقم الهاتف',
                style: getBoldStyle(
                  color: Colors.white,
                  fontSize: FontSizeApp.s22,
                ),
              ),
              Text(
                'الرجاء إدخال رقم الهاتف الخاص بك لتلقي رمز \n لإنشاء حساب عبر رقم الهاتف',
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
                  hintText: 'أضف رقمك',
                  icon: Icons.phone_android,
                ),
              ),
              CustomButton(
                label: 'أرسال',
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => OtpConfirmationScreen(),
                  //   ),
                  // );
                  sl<SignUpBloc>()
                      .add(RequestOtp(phoneNumber: textEditingController.text));
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
              top: -65,
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
              top: -60,
              left: -60,
              child: Image.asset(
                ImageManager.resetPasswordAsset,
                width: 280,
              ),
            ),
            Positioned(
              top: 75,
              left: -175,
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
              top: 80,
              left: -170,
              child: Image.asset(
                ImageManager.resetPasswordAsset2,
                width: 280,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
