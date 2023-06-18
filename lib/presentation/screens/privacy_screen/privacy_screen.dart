import 'package:absher/bloc/privacy_bloc/privacy_state.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../bloc/privacy_bloc/privacy_bloc.dart';
import '../../../bloc/privacy_bloc/privacy_event.dart';
import '../../../core/services/services_locator.dart';

import '../../widgets/custom_app_bar_screens.dart';
import '../../widgets/custom_error_screen.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PrivacyBloc>(
      create: (BuildContext context) => sl<PrivacyBloc>()..add(GetPrivacy()),
      child: const PrivacyBody(),
    );
  }
}

class PrivacyBody extends StatelessWidget {
  const PrivacyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBarScreens(
              title: AppLocalizations.of(context)!.privacy,
            ),
            Expanded(
              child: Container(
                color: Colors.white,
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
                        sl<PrivacyBloc>().add(GetPrivacy());
                      },
                    );
                  } else if (state is PrivacySuccess) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              Html(
                                data: state.content,
                              )
                            ]),
                      ),
                    );
                  } else {
                    return const Text("");
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
