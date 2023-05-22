import 'package:flutter/animation.dart';

abstract class StoriesEvent {
  StoriesEvent([List props = const []]) : super();
}

class SignUp extends StoriesEvent {}

class InitBloc extends StoriesEvent {
  final TickerProvider tickerProvider;
  InitBloc({required this.tickerProvider}) : super([tickerProvider]);
}

class CurrentStackIncrement extends StoriesEvent {}

class CurrentStackDecrement extends StoriesEvent {}

class OnStoryPageChanged extends StoriesEvent {
  final int index;
  OnStoryPageChanged({required this.index}) : super([index]);
}

class OnAnimationChange extends StoriesEvent {
  final bool? isForward;
  final bool? isStop;
  final double? forwardFrom;
  final double? value;
  OnAnimationChange({
    this.isForward,
    this.isStop,
    this.forwardFrom,
    this.value,
  }) : super([
          isForward,
          isStop,
          forwardFrom,
          value,
        ]);
}
