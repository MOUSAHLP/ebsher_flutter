import '../../models/notification_model.dart';
import '../../models/vendor_model.dart';

abstract class NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationError extends NotificationState {
  String error;
  NotificationError(this.error);
}

class NotificationSuccess extends NotificationState {
  List<NotificationModel> vendorsList;
  NotificationSuccess(this.vendorsList);
}
