import 'package:absher/bloc/login_bloc/login_event.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/core/app_validators.dart';
import 'package:absher/models/params/login_params.dart';
import 'package:absher/presentation/resources/font_app.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import '../../../bloc/login_bloc/login_bloc.dart';
import '../../../bloc/login_bloc/login_state.dart';
import '../../../core/services/services_locator.dart';
import '../../resources/color_manager.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/dialogs/error_dialog.dart';
import '../location_screen/widgets/app_bar_widget.dart';

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
            AppRouter.pushAndRemoveAllStack(context, BasicScreen());
          }
          if (state is LoginFieldsValidationFailed) {
            if (state.validationError != null) {
              toast(state.validationError!);
            }
          }
        },
        child: _SignInScreen());
  }
}

class _SignInScreen extends StatelessWidget {
  _SignInScreen({Key? key}) : super(key: key);
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const LoginScreenBackGround(),
        SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(
            bottom: 40,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 1.sh - 420,
                ),
                SizedBox(
                  // height: 350,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Form(
                      key: _formKey,
                      child: Column(children: [
                        // SizedBox(
                        //   height: 400,
                        // ),
                        Text(
                          AppLocalizations.of(context)!.signIn,
                          style: getBoldStyle(
                            color: Colors.white,
                            fontSize: FontSizeApp.s36,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.addDetails,
                          style: getBoldStyle(
                            color: Colors.white,
                            fontSize: FontSizeApp.s14,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomInputField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          hintText: AppLocalizations.of(context)!.addNumber,
                          withLabel: true,
                          icon: Icons.phone_android,
                          isPhone: true,
                          validator: (value) {
                            return AppValidators.validatePhoneFields(
                                context, phoneController.text);
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomPasswordInputField(
                          controller: passwordController,
                          hintText: AppLocalizations.of(context)!.password,
                          withLabel: true,
                          icon: Icons.lock_open_rounded,
                          validator: (value) {
                            return AppValidators.validatePasswordFields(
                                context, passwordController.text);
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            AppRouter.pushReplacement(
                              context,
                              const PhoneNumberSignUpScreen(
                                resetPassword: true,
                              ),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.forgetPassord,
                            style: getSemiBoldStyle(
                              color: ColorManager.softYellow,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomButton(
                          label: AppLocalizations.of(context)!.register,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              sl<LoginBloc>().add(
                                Login(
                                  loginParams: LoginParams(
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          AppLocalizations.of(context)!.or,
                          style: getBoldStyle(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomButton(
                          fillColor: Colors.white,
                          labelColor: Colors.white,
                          isFilled: false,
                          label: AppLocalizations.of(context)!.signUp,
                          onTap: () {
                            AppRouter.pushReplacement(
                                context,
                                const PhoneNumberSignUpScreen(
                                  resetPassword: false,
                                ));
                          },
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SafeArea(child: AppBarWidget())
      ],
    ));
  }
}
