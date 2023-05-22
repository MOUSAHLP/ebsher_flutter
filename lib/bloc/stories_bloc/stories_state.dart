import 'package:equatable/equatable.dart';

class StoriesState extends Equatable {
  const StoriesState({
    this.currentPageIndex = 0,
    this.currentPageValue = 0.0,
    this.currentStackIndex = 0,
    // this.descExpanded = false,
    // this.descHeight = 0.0,
    // this.storiesAnimationUpdate = const StoriesAnimationUpdate(),
    this.isForward = false,
    this.isStop = false,
    this.value,
    this.forwardFrom,
    this.indicatorValue,
  });

  final double currentPageValue;
  final int currentStackIndex;
  final int currentPageIndex;
  // final double descHeight;
  // final bool descExpanded;
  final double? value;
  final bool isStop;
  final bool isForward;
  final double? forwardFrom;
  final double? indicatorValue;

  StoriesState copyWith({
    double? currentPageValue,
    int? currentStackIndex,
    int? currentPageIndex,
    double? descHeight,
    bool? descExpanded,
    double? value,
    bool? isStop,
    bool? isForward,
    double? forwardFrom,
    double? indicatorValue,
  }) {
    return StoriesState(
      currentPageValue: currentPageValue ?? this.currentPageValue,
      currentStackIndex: currentStackIndex ?? this.currentStackIndex,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      // descHeight: descHeight ?? this.descHeight,
      // descExpanded: descExpanded ?? this.descExpanded,
      indicatorValue: indicatorValue ?? this.indicatorValue,
      isForward: isForward ?? false,
      isStop: isStop ?? false,
      value: value,
      forwardFrom: forwardFrom,
    );
  }

  @override
  List<Object?> get props => [
        currentPageValue,
        currentStackIndex,
        indicatorValue,
        currentPageIndex,
        // descHeight,
        // descExpanded,
        isForward,
        isStop,
        value,
        forwardFrom,
      ];
}
