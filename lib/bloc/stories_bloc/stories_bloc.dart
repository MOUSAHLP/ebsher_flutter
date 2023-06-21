import 'dart:developer';

import 'package:absher/bloc/stories_bloc/stories_event.dart';
import 'package:absher/bloc/stories_bloc/stories_state.dart';
import 'package:absher/core/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../data/repos/home_repository.dart';
import '../../models/story_model.dart';
import '../home_bloc/home_bloc.dart';
import '../home_bloc/home_event.dart';

class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  late AnimationController animationController;
  VideoPlayerController? playerController;
  PageController? pageController;
  List<StoryModelDto> stories = [];
  List<int> seeStory = [];

  StoriesBloc() : super(const StoriesState()) {
    on<StoriesEvent>((event, emit) async {
      if (event is CurrentStackIncrement) {
        animationController.duration = const Duration(seconds: 5);
        animationController.stop();
        if (state.currentStackIndex ==
            (stories[state.currentPageIndex].stories!.length - 1)) {
          if (state.currentPageIndex == stories.length - 1) {
            emit(ExitStories());
          } else {
            int s = state.currentPageIndex + 1;
            emit(state.copyWith(
              currentPageIndex: s,
              currentStackIndex: 0,
            ));
            animationController.value = 0;
            pageController!.animateToPage(
              state.currentPageIndex,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          }
        } else {
          int s = state.currentStackIndex + 1;
          emit(
            state.copyWith(
              currentStackIndex: s,
            ),
          );
          animationController.forward(from: 0);
        }
      }
      if (event is CurrentStackDecrement) {
        animationController.duration = const Duration(seconds: 5);
        animationController.stop();
        if (state.currentStackIndex == 0) {
          if (state.currentPageIndex != 0) {
            int newValue = state.currentPageIndex - 1;
            emit(state.copyWith(
              currentPageIndex: newValue,
              currentStackIndex: 0,
            ));
            animationController.forward(from: 0);
            pageController!.animateToPage(
              newValue,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          } else {
            emit(state.copyWith(
              currentStackIndex: 0,
            ));
          }
        } else {
          int newValue = state.currentStackIndex - 1;
          emit(state.copyWith(
            currentStackIndex: newValue,
          ));
          animationController.value = 0;
        }
      }
      if (event is OnStoryPageChanged) {
        emit(state.copyWith(
          currentStackIndex: 0,
          currentPageIndex: event.index,
        ));
        animationController.forward(from: 0);
      }
      if (event is AddIdStory) {
        seeStory.add(event.idStory);
        emit(SeeStorySuccess());
      }
      if (event is EndAddIdStory) {
        sl<HomeBloc>().add(ChangeSeeStory(seeStory));
        emit(EndSeeStorySuccess());
        final response = await HomeRepository.seeStories(seeStory);
        response.fold((l) {
        }, (r) {
         // sl<HomeBloc>().add(ChangeSeeStory(seeStory));
          emit(EndSeeStorySuccess());
        });
      }
    });
  }

  void init(List<StoryModelDto>? stories, int initIndex) {
    this.stories = stories ?? [];
    pageController = PageController(initialPage: initIndex);
    emit(state.copyWith(
      currentPageIndex: initIndex,
    ));
    pageController!.addListener(() {
      log(pageController!.page.toString());
      emit(state.copyWith(
        currentPageValue: pageController!.page!,
      ));
      if (pageController!.page == state.currentPageIndex.toDouble()) {
        animationController.forward();
        playerController?.play();
      }
    });
  }
}
