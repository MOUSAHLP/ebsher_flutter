

abstract class StoriesEvent {
  StoriesEvent([List props = const []]) : super();
}

class CurrentStackIncrement extends StoriesEvent {}

class CurrentStackDecrement extends StoriesEvent {}

class OnStoryPageChanged extends StoriesEvent {
  final int index;
  OnStoryPageChanged({required this.index}) : super([index]);
}
class AddIdStory extends StoriesEvent{
  int idStory;
  AddIdStory(this.idStory);
}
class EndAddIdStory extends StoriesEvent{}