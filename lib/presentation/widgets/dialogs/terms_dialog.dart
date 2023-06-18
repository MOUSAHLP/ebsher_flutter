import 'package:absher/bloc/login_bloc/login_bloc.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/core/app_router/dialog_transition_builder.dart';
import 'package:absher/data/data_resource/local_resource/data_store.dart';
import 'package:absher/presentation/widgets/dialogs/will_pop_scope_handler.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/privacy_bloc/privacy_bloc.dart';
import '../../../bloc/privacy_bloc/privacy_event.dart';
import '../../../bloc/privacy_bloc/privacy_state.dart';
import '../../../core/services/services_locator.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_app.dart';
import '../../resources/style_app.dart';
import '../custom_button.dart';
import '../custom_error_screen.dart';
import 'custom_dialog.dart';

class TermsDialog {
  static void openDialog(BuildContext context) {
    dialogTransitionBuilder(context, const _TermsAndConditionsDialog());
  }
}

class _TermsAndConditionsDialog extends StatelessWidget {
  const _TermsAndConditionsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PrivacyBloc>(
      create: (BuildContext context) => sl<PrivacyBloc>()..add(GetPrivacy()),
      child: const _TermsDialogBody(),
    );
  }
}

class _TermsDialogBody extends StatefulWidget {
  const _TermsDialogBody({
    Key? key,
  }) : super(key: key);

  @override
  State<_TermsDialogBody> createState() => _TermsDialogBodyState();
}

class _TermsDialogBodyState extends State<_TermsDialogBody> {
  bool termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => WillPopScopeHandler.handle(context),
      child: CustomDialog(
        icon: Icons.sim_card_alert_outlined,
        color: Colors.lightBlueAccent,
        content: SizedBox(
          height: 0.75.sh,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
            child: Column(
              children: [
                Text(
                  'Please accept Terms and Conditions in order to continue.',
                  style: getBoldStyle(
                    color: Colors.black,
                    fontSize: FontSizeApp.s14,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: BlocBuilder<PrivacyBloc, PrivacyState>(
                    builder: (context, state) {
                      if (state is PrivacyLoading) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: ColorManager.primaryColor,
                        ));
                      } else if (state is PrivacyError) {
                        return CustomErrorScreen(
                          onTap: () {
                            context.read<PrivacyBloc>().add(GetPrivacy());
                          },
                        );
                      } else if (state is PrivacySuccess) {
                        return Column(children: [
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Html(
                                data: state.content,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: termsAccepted,
                                  onChanged: (value) {
                                    setState(() {
                                      termsAccepted = value ?? false;
                                    });
                                  }),
                              Text('I agree to Terms And Conditions.')
                            ],
                          )
                        ]);
                      } else {
                        return const Text("");
                      }
                    },
                  ),
                ),
                CustomButton(
                  label: 'Continue',
                  fillColor: termsAccepted
                      ? ColorManager.primaryColor
                      : ColorManager.labelGrey,
                  onTap: () {
                    if (termsAccepted) {
                      DataStore.instance.setTermsIsViewed();
                      AppRouter.pop(context);
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                CustomButton(
                  label: 'Close App',
                  fillColor: ColorManager.darkRed,
                  onTap: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
