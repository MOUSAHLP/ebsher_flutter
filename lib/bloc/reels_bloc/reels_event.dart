import 'package:flutter/animation.dart';

abstract class ReelsEvent {
  ReelsEvent([List props = const []]) : super();
}
class getReels extends ReelsEvent {}