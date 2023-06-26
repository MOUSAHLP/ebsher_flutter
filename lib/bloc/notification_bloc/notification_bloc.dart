import 'package:absher/bloc/notification_bloc/notification_event.dart';
import 'package:absher/data/data_resource/local_resource/data_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/notification_repository.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
bool isEnable=DataStore.instance.enableNotifications;
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
      if (event is SetNotificationEnable) {
       isEnable=!isEnable;
        emit(NotificationSuccessEnable());
       final response =   await NotificationRepository.setNotificationsEnable(event.id);
       response.fold((l) {
         isEnable=!isEnable;
         emit(NotificationSuccessEnable());
       }, (r) {
         DataStore.instance.setEnableNotifications(isEnable);
       });
      }
    });
  }
}
