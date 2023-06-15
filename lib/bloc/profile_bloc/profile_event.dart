import 'package:absher/models/advertisement_response.dart';
import 'package:absher/models/category_response.dart';

abstract class ProfileEvent {
  ProfileEvent([List props = const []]) : super();
}
class getProfile extends ProfileEvent {}
class isEditingEvent extends ProfileEvent {
  bool isEditing;
  isEditingEvent(this.isEditing);
}
