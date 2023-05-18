import 'package:absher/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:absher/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:absher/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/auth_screen/sign_in_screen.dart';
import 'package:absher/presentation/screens/auth_screen/widgets/sign_up_background_decoration.dart';
import 'package:absher/presentation/widgets/custom_input_field.dart';
import 'package:absher/presentation/widgets/dialogs/error_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../resources/color_manager.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_loader.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final _formState = GlobalKey<FormState>();
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
        if (state is SignUpCompleted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => SignInConfirmationScreen(),
            ),
          );
        }
        if (state is SignUpFieldsValidationFailed) {
          if (state.validationError != null) {
            toast(state.validationError!);
          }
        }
      },
      child: Scaffold(
          body: Stack(
        children: [
          const SignUpBackGroundDecoration(),
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16),
              child: Form(
                key: _formState,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 240,
                    ),
                    Text(
                      'أنشاء حساب',
                      style: getBoldStyle(
                        color: Colors.white,
                        fontSize: FontSizeApp.s36,
                      ),
                    ),
                    Text(
                      'أضف التفاصيل الخاصة بك لتسجيل حساب',
                      style: getBoldStyle(
                        color: Colors.white,
                        fontSize: FontSizeApp.s14,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomInputField(
                      hintText: 'الاسم بالكامل',
                      withLabel: true,
                      icon: Icons.person,
                      onChange: (value) {
                        context.read<SignUpBloc>().signUpParams.name = value;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomInputField(
                      hintText: 'أضف رقمك',
                      initValue: context.read<SignUpBloc>().signUpParams.phone,
                      readOnly: true,
                      withLabel: true,
                      icon: Icons.phone_android,
                      onChange: (value) {
                        context.read<SignUpBloc>().signUpParams.phone = value;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomInputField(
                      hintText: 'أدخل بريدك الإلكتروني',
                      withLabel: true,
                      icon: Icons.email,
                      onChange: (value) {
                        context.read<SignUpBloc>().signUpParams.email = value;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomInputField(
                      hintText: 'كلمة المرور',
                      withLabel: true,
                      icon: Icons.lock_open_rounded,
                      onChange: (value) {
                        context.read<SignUpBloc>().signUpParams.password =
                            value;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomInputField(
                      hintText: 'تأكيد كلمة المرور',
                      withLabel: true,
                      icon: Icons.lock_open_rounded,
                      onChange: (value) {
                        context.read<SignUpBloc>().signUpParams.repeatPassword =
                            value;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomButton(
                      label: 'تسجيل',
                      onTap: () {
                        context.read<SignUpBloc>().add(SignUp());
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'هل لديك حساب؟',
                            style: getBoldStyle(
                              color: Colors.white,
                              fontSize: FontSizeApp.s14,
                            ),
                          ),
                          const TextSpan(text: ' '),
                          TextSpan(
                            text: 'تسجيل الدخول',
                            style: getBoldStyle(
                              color: ColorManager.softYellow,
                              fontSize: FontSizeApp.s14,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SignInConfirmationScreen(),
                                        ),
                                      ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
