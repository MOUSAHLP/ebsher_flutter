

abstract class ProfileEvent {
  ProfileEvent([List props = const []]) : super();
}

class GetProfile extends ProfileEvent {}

class IsEditingEvent extends ProfileEvent {
  bool isEditing;
  IsEditingEvent(this.isEditing);
}

class UpdateProfile extends ProfileEvent {}

class GetImageGallery extends ProfileEvent {}
