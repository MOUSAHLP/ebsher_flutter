import 'package:absher/presentation/widgets/custom_app_bar_screens.dart';
import 'package:flutter/material.dart';
import '../../../../translations.dart';
import '../../widgets/custom_app_background.dart';
import 'notification_widget/build_notification_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBackGround(
        child: SafeArea(
            child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              ListView.separated(
                itemBuilder: (context, index) {
                  return BuildNotificationWidget(
                    index.isOdd ? true : false,
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                    height: 3, color: Colors.white, indent: 30, endIndent: 30),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 20,
                shrinkWrap: true,
              ),
            ],
          ),
        ),
        Stack(
          children: [
            CustomAppBarScreens(
              title: AppLocalizations.of(context)!.notification,
            )
          ],
        ),
      ],
    )));
  }
}
