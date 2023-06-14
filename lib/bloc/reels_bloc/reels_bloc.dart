import 'dart:developer';

import 'package:absher/bloc/reels_bloc/reels_event.dart';
import 'package:absher/bloc/reels_bloc/reels_state.dart';
import 'package:absher/models/reels_model.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import '../../data/repos/home_repository.dart';
import '../../models/story_model.dart';
class ReelsBloc extends Bloc<ReelsEvent, ReelsState> {
  VideoPlayerController? playerController;
  List<ReelsModel> stories = [];
  SwiperController? controller=SwiperController();

  ReelsBloc() : super( ReelsLoading()) {
    on<ReelsEvent>((event, emit) async {
      if (event is getReels) {
        emit(ReelsLoading());
        final response = await HomeRepository.getReels();
        response.fold((l) {
          emit(ReelsError(l));
        }, (r) {
          stories=r;
          print("=============sto");
          print(stories);
          print("=============rrrr");
          print(r);
          emit(ReelsSuccess(r));

        });
      }

    });
  }

  void init(List<ReelsModel>? stories) {
    this.stories = stories ?? [];
    controller!.next();
  }
}
