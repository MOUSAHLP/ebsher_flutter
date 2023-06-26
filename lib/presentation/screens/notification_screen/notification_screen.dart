import 'package:absher/bloc/notification_bloc/notification_bloc.dart';
import 'package:absher/presentation/widgets/custom_app_bar_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../translations.dart';
import '../../../bloc/authentication_bloc/authertication_bloc.dart';
import '../../../bloc/notification_bloc/notification_event.dart';
import '../../../bloc/notification_bloc/notification_state.dart';
import '../../../core/services/services_locator.dart';
import '../../widgets/custom_app_background.dart';
import '../../widgets/custom_error_screen.dart';
import '../../widgets/custom_guest.dart';
import '../../widgets/custom_no_data_screen.dart';
import 'notification_widget/build_notification_widget.dart';
import 'notification_widget/build_shimmer_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationBloc>(
      create: (BuildContext context) =>
          sl<NotificationBloc>()..add(GetNotificationList()),
      child: const NotificationBody(),
    );
  }
}

class NotificationBody extends StatelessWidget {
  const NotificationBody({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomAppBackGround(
        child: SafeArea(
            child: Stack(
      children: [
        sl<AuthenticationBloc>().loggedIn? BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
          if (state is NotificationLoading) {
            return const BuildShimmerNotification();
          } else if (state is NotificationError) {
            return Center(
              child: CustomErrorScreen(
                onTap: () {
                  sl<NotificationBloc>().add(GetNotificationList());
                },
              ),
            );
          } else if (state is NotificationSuccess) {
            return   state.vendorsList.isNotEmpty? SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 60),
              ListView.separated(itemBuilder: (context, index) {
                      return BuildNotificationWidget(
                      isSee:   index.isOdd ? true : false,
                        notificationModel: state.vendorsList[index],
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                        height: 3,
                        color: Colors.white,
                        indent: 30,
                        endIndent: 30),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:  state.vendorsList.length,
                    shrinkWrap: true,
                  )
                ],
              )
            ):
            const CustomNoDataScreen();

          } else {
            return const Text("");
          }
        }):const CustomGuest(),
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
