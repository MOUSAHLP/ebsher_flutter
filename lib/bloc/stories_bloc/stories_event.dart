import 'package:flutter/animation.dart';

abstract class StoriesEvent {
  StoriesEvent([List props = const []]) : super();
}

class CurrentStackIncrement extends StoriesEvent {}

class CurrentStackDecrement extends StoriesEvent {}

class OnStoryPageChanged extends StoriesEvent {
  final int index;
  OnStoryPageChanged({required this.index}) : super([index]);
}