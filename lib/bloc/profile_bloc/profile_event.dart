

import '../../models/profile_model.dart';

abstract class ProfileEvent {
  ProfileEvent([List props = const []]) : super();
}
class getProfile extends ProfileEvent {}
class isEditingEvent extends ProfileEvent {
  bool isEditing;
  isEditingEvent(this.isEditing);
}
class UpdateProfile extends ProfileEvent{
}
class GetImageGallery extends ProfileEvent{
}
class GetImageCamera extends ProfileEvent{
}

