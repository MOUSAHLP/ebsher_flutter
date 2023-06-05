import 'package:absher/models/advertisement_response.dart';
import 'package:absher/models/category_response.dart';

abstract class BottomEvent {
  BottomEvent([List props = const []]) : super();
}

class NewBottomChange extends BottomEvent {
  int index;
  NewBottomChange(this.index);
}
