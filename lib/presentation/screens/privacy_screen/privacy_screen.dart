import 'package:absher/bloc/privacy_bloc/privacy_state.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../bloc/privacy_bloc/privacy_bloc.dart';
import '../../../bloc/privacy_bloc/privacy_event.dart';
import '../../../core/services/services_locator.dart';

import '../../widgets/custom_error_screen.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PrivacyBloc>(
      create: (BuildContext context) => sl<PrivacyBloc>()..add(getPrivacy()),
      child: const PrivacyBody(),
    );
  }
}

class PrivacyBody extends StatelessWidget {
  const PrivacyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.backgroundEndColor,
            title: Text(AppLocalizations.of(context)!.privacy),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              BlocBuilder<PrivacyBloc, PrivacyState>(builder: (context, state) {
                if (state is PrivacyLoading) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: ColorManager.primaryColor,
                  ));
                } else if (state is PrivacyError) {
                  return CustomErrorScreen(
                    onTap: () {
                      sl<PrivacyBloc>().add(getPrivacy());
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
            ],
          )),
    );
  }
}
