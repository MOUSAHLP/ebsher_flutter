import 'package:absher/models/story_model.dart';

import '../../models/advertisement_response.dart';
import '../../models/category_response.dart';
import '../../models/profile_model.dart';
import '../../models/search_response.dart';

abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileError extends ProfileState {
  String error;
  ProfileError(this.error);
}
class ProfileSuccess extends ProfileState {
  ProfileModel profileModel;

  ProfileSuccess(this.profileModel,);
}
