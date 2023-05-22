import 'package:absher/bloc/stories_bloc/stories_event.dart';
import 'package:absher/bloc/stories_bloc/stories_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/story_model.dart';

class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  late AnimationController animationController;

  PageController? pageController;

  List<StoryModelDto>? stories = dummyStories;
  int initIndex = 0;

  StoriesBloc() : super(const StoriesState()) {
    on<StoriesEvent>((event, emit) async {
      if (event is CurrentStackIncrement) {
        if (state.currentStackIndex ==
            (stories![state.currentPageIndex].stories!.length - 1)) {
          if (state.currentPageIndex == stories!.length - 1) {
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
    });
  }

  void init() {
    stories = dummyStories;
    initIndex = 0;
    pageController = PageController(initialPage: initIndex);
    emit(state.copyWith(
      currentPageValue: 0.0,
      currentStackIndex: 0,
    ));
    pageController!.addListener(() {
      emit(state.copyWith(
        currentPageValue: pageController!.page!,
      ));
    });
  }
}
