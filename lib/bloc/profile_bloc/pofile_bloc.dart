import 'package:absher/bloc/home_bloc/home_event.dart';
import 'package:absher/bloc/home_bloc/home_state.dart';
import 'package:absher/bloc/profile_bloc/profile_event.dart';
import 'package:absher/bloc/profile_bloc/profile_state.dart';
import 'package:absher/models/story_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/home_repository.dart';
import '../../models/category_response.dart';
import '../../models/profile_model.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileModel profileModel=ProfileModel();
  ProfileBloc() : super(ProfileLoading()) {
    on<ProfileEvent>((event, emit) async {
      print("eeeeee");

      if (event is getProfile) {
        emit(ProfileLoading());
        final response = await HomeRepository.getProfile();
        response.fold((l) {
          emit(ProfileError(l));
        }, (r) {
          profileModel=r;
          emit(ProfileSuccess(profileModel,false));
        });
      }
      if(event is isEditingEvent){
        print('isEdit');
        print(profileModel);
        print(event.isEditing);
        emit(ProfileLoading());
        emit(ProfileSuccess(profileModel,event.isEditing));
      }
    });
  }
}
