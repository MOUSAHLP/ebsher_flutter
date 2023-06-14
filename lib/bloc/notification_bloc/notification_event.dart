abstract class NotificationEvent {
  NotificationEvent([List props = const []]) : super();
}

class GetNotificationList extends NotificationEvent {
  GetNotificationList();
}
