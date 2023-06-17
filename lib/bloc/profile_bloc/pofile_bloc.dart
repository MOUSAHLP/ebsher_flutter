
import 'dart:io';

import 'package:absher/bloc/profile_bloc/profile_event.dart';
import 'package:absher/bloc/profile_bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/home_repository.dart';
import '../../models/profile_model.dart';
import 'package:image_picker/image_picker.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileModel profileModel=ProfileModel();
  File? image;
  final picker = ImagePicker();

  String extractName(String path) {
    int i;
    for (i = path.length - 1; i >= 0; i--) {
      if (path[i] == "/") break;
    }
    return path.substring(i + 1);
  }

  Future getImageCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
  }

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {}

  }


  ProfileBloc() : super(ProfileLoading()) {
    on<ProfileEvent>((event, emit) async {
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
        emit(ProfileSuccess(profileModel,event.isEditing));
      }
      if (event is UpdateProfile) {
        emit(ProfileLoading());
        print("update profileModel.name");
        print(profileModel.name);
        String? validationError;
       // AppValidators.validateSignUpFields(profileModel);
        if (validationError == null) {
          var response = await HomeRepository.editProfile(profileModel);
          response.fold((l) {
            emit(ProfileError( l));
          }, (r) {
            emit(ProfileSuccess(profileModel,false));
          });
        }
        else {
          emit(SignUpFieldsValidationFailed(validationError: validationError));
        }
      }
      if(event is GetImageGallery ){
        getImageGallery();
        emit(ImageSuccess());
      }
      if(event is GetImageCamera ){
        getImageCamera();
        emit(ImageSuccess());
      }
    });
  }
}
