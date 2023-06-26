
abstract class BottomEvent {
  BottomEvent([List props = const []]) : super();
}

class NewBottomChange extends BottomEvent {
  int index;
  NewBottomChange(this.index);
}
