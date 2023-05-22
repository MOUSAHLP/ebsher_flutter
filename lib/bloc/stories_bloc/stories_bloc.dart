import 'dart:developer';

import 'package:absher/bloc/stories_bloc/stories_event.dart';
import 'package:absher/bloc/stories_bloc/stories_state.dart';
import 'package:absher/core/services/services_locator.dart';
import 'package:absher/data/repos/user_repository.dart';
import 'package:absher/presentation/screens/story_screen/story_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/story_model.dart';

class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  final UserRepository userRepository;

  bool _controllerDisposed = false;

  late AnimationController animationController;
  late VoidCallback listener;
  late Animation<double> indicatorAnimation;
  double indicatorAnimationValue = 0;

  PageController? pageController;

  List<StoryModelDto>? stories = dummyStories;
  int initIndex = 0;

  StoriesBloc(
    this.userRepository,
  ) : super(const StoriesState()) {
    on<StoriesEvent>((event, emit) async {
      if (event is InitBloc) {
        // init(event.tickerProvider, emit);
      }
      if (event is CurrentStackIncrement) {
        log('Current called');
        // descExpanded = false;
        if (state.currentStackIndex ==
            (stories![state.currentPageIndex].stories!.length - 1)) {
          log('current 1');
          // emit(state.copyWith(
          //   currentStackIndex: 0,
          //   // value: 1,
          // ));
          if (state.currentPageIndex == stories!.length - 1) {
            log('finished');
            // Get.back();
          } else {
            log('current 2');
            int s = state.currentPageIndex + 1;
            emit(state.copyWith(
              currentPageIndex: s,
              currentStackIndex: 0,
              value: 0,
            ));
            pageController!.animateToPage(
              state.currentPageIndex,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          }
        } else {
          log('current 3');
          // log('before ${state.currentPageIndex} , ${state.currentStackIndex}');
          int s = state.currentStackIndex + 1;
          emit(
            state.copyWith(
              currentStackIndex: s,
              isForward: true,
              forwardFrom: 0,
            ),
          );
          // log('after ${state.currentPageIndex} , ${state.currentStackIndex}');
        }
        log('after ${state.currentPageIndex} , ${state.currentStackIndex}');
      }
      if (event is CurrentStackDecrement) {
        // descExpanded = false;
        if (state.currentStackIndex == 0) {
          if (state.currentPageIndex != 0) {
            int newValue = state.currentPageIndex - 1;
            emit(state.copyWith(
              currentPageIndex: newValue,
              currentStackIndex: 0,
              value: 0,
              isForward: true,
            ));
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
            // forwardFrom: 0,
            value: 0,
            // isForward: true,
            currentStackIndex: newValue,
          ));
        }
      }
      if (event is OnAnimationChange) {
        emit(state.copyWith(
          isForward: event.isForward,
          isStop: event.isStop,
          value: event.value,
          forwardFrom: event.forwardFrom,
        ));
      }
      if (event is OnStoryPageChanged) {
        emit(state.copyWith(
          currentStackIndex: 0,
          currentPageIndex: event.index,
          // value: 0,
          isForward: true,
        ));
      }
    });
  }

  void init() {
    stories = dummyStories;
    initIndex = 0;
    pageController = PageController(initialPage: initIndex);
    emit(state.copyWith(
      currentPageValue: 0.0,
    ));
    pageController!.addListener(() {
      emit(state.copyWith(
        currentPageValue: pageController!.page!,
      ));
    });
  }
}
