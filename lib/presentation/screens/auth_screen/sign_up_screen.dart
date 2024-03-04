import 'package:absher/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:absher/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:absher/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/auth_screen/sign_in_screen.dart';
import 'package:absher/presentation/screens/auth_screen/widgets/sign_up_background_decoration.dart';
import 'package:absher/presentation/widgets/custom_input_field.dart';
import 'package:absher/presentation/widgets/custom_password_input_field.dart';
import 'package:absher/presentation/widgets/dialogs/error_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../core/app_validators.dart';
import '../../../translations.dart';
import '../../resources/color_manager.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/dialogs/loading_dialog.dart';
import '../location_screen/widgets/app_bar_widget.dart';

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
          AppRouter.pushReplacement(context, const SignInConfirmationScreen());
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Form(
                key: _formState,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Column(
                    children: [
                      SizedBox(height: 1.sh - 510),
                      SizedBox(
                        // height: 500,
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.signUp,
                              style: getBoldStyle(
                                color: Colors.white,
                                fontSize: FontSizeApp.s36,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!
                                  .addYourDetailsToSignIn,
                              style: getBoldStyle(
                                color: Colors.white,
                                fontSize: FontSizeApp.s14,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomInputField(
                              hintText: AppLocalizations.of(context)!.fullName,
                              withLabel: true,
                              icon: Icons.person,
                              onChange: (value) {
                                context.read<SignUpBloc>().signUpParams.name =
                                    value;
                              },
                              validator: (value) {
                                return AppValidators.validateNameFields(
                                    context, value);
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomInputField(
                              hintText: AppLocalizations.of(context)!.addNumber,
                              initValue:
                                  context.read<SignUpBloc>().signUpParams.phone,
                              readOnly: true,
                              withLabel: true,
                              icon: Icons.phone_android,
                              isPhone: true,
                              onChange: (value) {
                                context.read<SignUpBloc>().signUpParams.phone =
                                    value;
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomInputField(
                              hintText:
                                  AppLocalizations.of(context)!.enterEmail,
                              withLabel: true,
                              icon: Icons.email,
                              onChange: (value) {
                                context.read<SignUpBloc>().signUpParams.email =
                                    value;
                              },
                              // validator: (value) {
                              //   return AppValidators.validateEmailFields(
                              //       context, value);
                              // },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomPasswordInputField(
                              hintText: AppLocalizations.of(context)!.password,
                              withLabel: true,
                              icon: Icons.lock_open_rounded,
                              onChange: (value) {
                                context
                                    .read<SignUpBloc>()
                                    .signUpParams
                                    .password = value;
                              },
                              validator: (value) {
                                return AppValidators.validatePasswordFields(
                                    context, value);
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomPasswordInputField(
                              hintText:
                                  AppLocalizations.of(context)!.confimPassword,
                              withLabel: true,
                              icon: Icons.lock_open_rounded,
                              onChange: (value) {
                                context
                                    .read<SignUpBloc>()
                                    .signUpParams
                                    .repeatPassword = value;
                              },
                              validator: (value) {
                                return AppValidators
                                    .validateRepeatPasswordFields(
                                        context,
                                        context
                                            .read<SignUpBloc>()
                                            .signUpParams
                                            .password,
                                        value);
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomButton(
                              label: AppLocalizations.of(context)!.register,
                              onTap: () {
                                if (_formState.currentState!.validate()) {
                                  context.read<SignUpBloc>().add(SignUp());
                                }
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
                                    text: AppLocalizations.of(context)!
                                        .haveAccount,
                                    style: getBoldStyle(
                                      color: Colors.white,
                                      fontSize: FontSizeApp.s14,
                                    ),
                                  ),
                                  const TextSpan(text: ' '),
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.signIn,
                                    style: getBoldStyle(
                                      color: ColorManager.softYellow,
                                      fontSize: FontSizeApp.s14,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => AppRouter.pushReplacement(
                                          context,
                                          const SignInConfirmationScreen()),
                                  ),
                                ],
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
          ),
          const SafeArea(child: AppBarWidget())
        ],
      )),
    );
  }
}
