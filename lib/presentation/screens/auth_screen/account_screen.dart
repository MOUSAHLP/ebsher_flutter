import 'package:absher/bloc/login_bloc/login_bloc.dart';
import 'package:absher/bloc/login_bloc/login_event.dart';
import 'package:absher/bloc/login_bloc/login_state.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/screens/auth_screen/phone_number_signup_screen.dart';
import 'package:absher/presentation/screens/auth_screen/sign_in_screen.dart';
import 'package:absher/presentation/widgets/dialogs/terms_dialog.dart';
import 'package:absher/presentation/widgets/dialogs/will_pop_scope_handler.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/authentication_bloc/authentication_event.dart';
import '../../../bloc/authentication_bloc/authertication_bloc.dart';
import '../../../core/services/services_locator.dart';
import '../../resources/color_manager.dart';
import '../../widgets/custom_app_background.dart';
import '../../widgets/custom_button.dart';
import '../home_screen/basic_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => WillPopScopeHandler.handle(context),
      child: BlocListener<LoginBloc, LoginState>(
        bloc: sl<LoginBloc>()..add(CheckForTermsAcceptance()),
        listener: (context, state) {
          if (state is TermsAcceptRequired) {
            TermsDialog.openDialog(context);
          }
        },
        child: Scaffold(
            body: Stack(
          children: [
            CustomAppBackGround(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 140,
                      child: Image.asset(
                        ImageManager.fullAppLogo,
                      ),
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    CustomButton(
                      fillColor: Colors.white,
                      labelColor: ColorManager.primaryColor,
                      label: AppLocalizations.of(context)!.signIn,
                      onTap: () {
                        AppRouter.push(context, const SignInConfirmationScreen());
                      },
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
                        AppRouter.push(
                            context,
                            const PhoneNumberSignUpScreen(
                              resetPassword: false,
                            ));
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomButton(
                      fillColor: Colors.white,
                      labelColor: Colors.white,
                      isFilled: false,
                      label:AppLocalizations.of(context)!.guest,
                      onTap: () {
                        sl<AuthenticationBloc>().add(LoggedGuest());
                        AppRouter.pushAndRemoveAllStack(context, BasicScreen());
                      },
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                Positioned(
                  top: -25,
                  right: -55,
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
                  top: -32,
                  right: -60,
                  child: Image.asset(
                    ImageManager.accountAsset,
                    width: 280,
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
