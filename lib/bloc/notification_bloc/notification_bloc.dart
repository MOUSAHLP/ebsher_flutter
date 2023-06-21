import 'package:absher/bloc/notification_bloc/notification_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/notification_repository.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationLoading()) {
    on<NotificationEvent>((event, emit) async {
      if (event is GetNotificationList) {
        emit(NotificationLoading());
        final response = await NotificationRepository.getNotifications();
        response.fold((l) {
          emit(NotificationError(l));
        }, (r) {
          emit(NotificationSuccess(r));
        });
      }
    });
  }
}
