import 'package:equatable/equatable.dart';

class StoriesState extends Equatable {
  const StoriesState({
    this.currentPageIndex = 0,
    this.currentPageValue = 0.0,
    this.currentStackIndex = 0,
  });

  final double currentPageValue;
  final int currentStackIndex;
  final int currentPageIndex;

  StoriesState copyWith({
    double? currentPageValue,
    int? currentStackIndex,
    int? currentPageIndex,
  }) {
    return StoriesState(
      currentPageValue: currentPageValue ?? this.currentPageValue,
      currentStackIndex: currentStackIndex ?? this.currentStackIndex,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
    );
  }

  @override
  List<Object?> get props => [
        currentPageValue,
        currentStackIndex,
        currentPageIndex,
      ];
}

class ExitStories extends StoriesState {}
