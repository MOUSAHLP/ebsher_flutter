

abstract class HomeEvent {
  HomeEvent([List props = const []]) : super();
}

class Home extends HomeEvent {}
class ChangeSeeStory extends HomeEvent{
  List<int> listIndex;
  ChangeSeeStory(this.listIndex);
}