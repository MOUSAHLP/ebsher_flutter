import 'dart:io';

import 'package:absher/bloc/authentication_bloc/authertication_bloc.dart';
import 'package:absher/bloc/profile_bloc/profile_event.dart';
import 'package:absher/bloc/profile_bloc/profile_state.dart';
import 'package:absher/models/login_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/app_validators.dart';
import '../../core/services/services_locator.dart';
import '../../data/data_resource/local_resource/data_store.dart';
import '../../data/repos/home_repository.dart';
import '../../models/profile_model.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileModel profileModel = ProfileModel();
  TextEditingController nameController =
      TextEditingController(text: DataStore.instance.userInfo?.name);
  TextEditingController emailController =
      TextEditingController(text: DataStore.instance.userInfo?.email);
  String? image = DataStore.instance.userInfo?.image;

  bool isEditing = false;
  File? imagePick;
  final picker = ImagePicker();

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePick = File(pickedFile.path);
      emit(ImageSuccess());
    } else {}
  }

  ProfileBloc() : super(ProfileInit()) {
    on<ProfileEvent>((event, emit) async {
      if (event is IsEditingEvent) {
        isEditing = event.isEditing;
        emit(ProfileSuccess(profileModel, event.isEditing));
      }
      if (event is UpdateProfile) {
        emit(ProfileLoading());
        profileModel.name = nameController.text;
        profileModel.email = emailController.text;
        profileModel.avatar = imagePick?.path;
        var response = await HomeRepository.editProfile(profileModel);
        response.fold((l) {
          emit(ProfileError(l));
        }, (r) {
          add(GetProfile());
        });
      }
      if (event is GetProfile) {
        emit(ProfileLoading());
        var profileResponse = await HomeRepository.getProfile();
        profileResponse.fold((l) {
          emit(ProfileError(l));
        }, (r) {
          LoginResponse result = LoginResponse(
              id: r.id ?? DataStore.instance.userInfo!.id,
              name: nameController.text,
              phone: profileModel.phone!,
              email: profileModel.email!,
              token: profileModel.deviceToken ?? "",
              image: r.avatar);
          sl<AuthenticationBloc>().loginResponse = result;
          DataStore.instance.setUserInfo(result);
          emit(ProfileSuccess(profileModel, false));
        });
      }

      if (event is GetImageGallery) {
        getImageGallery();
      }
    });
  }
}
