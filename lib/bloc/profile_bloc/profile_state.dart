
import '../../models/profile_model.dart';

abstract class ProfileState {}

class ProfileLoading extends ProfileState {}
class ProfileInit extends ProfileState {}
class ProfileError extends ProfileState {
  String error;
  ProfileError(this.error);
}
class ProfileSuccess extends ProfileState {
  ProfileModel profileModel;
  bool isEditing;
  ProfileSuccess(this.profileModel,this.isEditing);
}
class ProfileFieldsValidationFailed extends ProfileState {
  final String? validationError;
  ProfileFieldsValidationFailed({this.validationError});
}
class ImageSuccess extends ProfileState{}

