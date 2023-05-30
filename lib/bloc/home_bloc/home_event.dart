import 'package:absher/models/advertisement_response.dart';
import 'package:absher/models/category_response.dart';

abstract class HomeEvent {
  HomeEvent([List props = const []]) : super();
}

class Home extends HomeEvent {}
