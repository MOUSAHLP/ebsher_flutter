import 'dart:math';
import 'dart:ui';

import 'package:absher/bloc/stories_bloc/stories_bloc.dart';
import 'package:absher/bloc/stories_bloc/stories_event.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/core/services/services_locator.dart';
import 'package:absher/presentation/screens/story_screen/widgets/gestures.dart';
import 'package:absher/presentation/screens/story_screen/widgets/indicators.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/stories_bloc/stories_state.dart';
import 'widgets/story_item.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({Key? key}) : super(key: key);

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StoriesBloc>(
      create: (BuildContext context) => StoriesBloc(sl())..init(),
      lazy: false,
      child: StoryScreenBody(),
    );
  }
}

class StoryScreenBody extends StatefulWidget {
  const StoryScreenBody({Key? key}) : super(key: key);

  @override
  State<StoryScreenBody> createState() => _StoryScreenBodyState();
}

class _StoryScreenBodyState extends State<StoryScreenBody>
    with TickerProviderStateMixin {
  late StoriesBloc storiesBloc;

  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;
  late VoidCallback listener;
  late Animation<double> indicatorAnimation;
  double indicatorAnimationValue = 0;

  @override
  void initState() {
    storiesBloc = context.read<StoriesBloc>();
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
      IndicatorAnimationCommand.resume,
    );
    storiesBloc.animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            storiesBloc.add(CurrentStackIncrement());
          }
        },
      );
    listener = () {
      switch (indicatorAnimationController.value) {
        case IndicatorAnimationCommand.pause:
          storiesBloc.animationController.stop();
          break;
        case IndicatorAnimationCommand.resume:
        default:
          storiesBloc.animationController.forward();
          break;
      }
    };

    indicatorAnimationController.addListener(listener);

    indicatorAnimation =
        Tween(begin: 0.0, end: 1.0).animate(storiesBloc.animationController)
          ..addListener(() {
            setState(() {
              indicatorAnimationValue = indicatorAnimation.value;
            });
          });
    super.initState();
  }

  @override
  void dispose() {
    storiesBloc.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () {
        AppRouter.pop(context);
      },
      key: const Key(''),
      child: BlocBuilder<StoriesBloc, StoriesState>(builder: (context, state) {
        // if (!widget.isCurrentPage && widget.isPaging) {
        //   storiesBloc.animationController.stop();
        // }

        return SafeArea(
          child: Scaffold(
            body: ColoredBox(
              color: Colors.black,
              child: PageView.builder(
                controller: storiesBloc.pageController,
                itemCount: storiesBloc.stories!.length,
                onPageChanged: (newPageIndex) {
                  print('pageChanged');
                  context
                      .read<StoriesBloc>()
                      .add(OnStoryPageChanged(index: newPageIndex));
                  // storyController.currentStackIndex.value = 0;
                  // storyController.currentPageIndex.value = newPageIndex;
                  // storyController.animationController.value = 0;
                },
                itemBuilder: (context, index) {
                  final isLeaving = (index - state.currentPageValue) <= 0;
                  final t = index - state.currentPageValue;
                  final rotationY = lerpDouble(0, 30, t)!;
                  const maxOpacity = 0.8;
                  final num opacity = lerpDouble(0, maxOpacity, t.abs())!
                      .clamp(0.0, maxOpacity);
                  final isPaging = opacity != maxOpacity;
                  final transform = Matrix4.identity();
                  transform.setEntry(3, 2, 0.003);
                  transform.rotateY(-rotationY * (pi / 180.0));
                  return Transform(
                    alignment: isLeaving
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    transform: transform,
                    child: Stack(
                      children: [
                        _StoryPageFrame(
                          storyLength:
                              storiesBloc.stories![index].stories!.length,
                          pageIndex: index,
                          animateToPage: (index) {
                            storiesBloc.pageController!.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          isCurrentPage: state.currentPageValue == index,
                          isPaging: isPaging,
                          itemBuilder: (context, pageIndex, storyIndex) {
                            return StoryItem(
                              storyIndex: storyIndex,
                              pageIndex: pageIndex,
                            );
                          },
                          indicatorAnimationValue: indicatorAnimationValue,
                        ),
                        if (isPaging && !isLeaving)
                          Positioned.fill(
                            child: Opacity(
                              opacity: opacity as double,
                              child: const ColoredBox(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _StoryPageFrame extends StatefulWidget {
  const _StoryPageFrame({
    required this.pageIndex,
    required this.animateToPage,
    required this.storyLength,
    required this.isCurrentPage,
    required this.isPaging,
    required this.itemBuilder,
    this.gestureItemBuilder,
    Key? key,
    required this.indicatorAnimationValue,
  }) : super(key: key);

  final int pageIndex;
  final ValueChanged<int> animateToPage;
  final int storyLength;
  final bool isCurrentPage;
  final bool isPaging;
  final StoryItemBuilder itemBuilder;
  final StoryItemBuilder? gestureItemBuilder;
  final double indicatorAnimationValue;

  @override
  State<_StoryPageFrame> createState() => _StoryPageFrameState();
}

class _StoryPageFrameState extends State<_StoryPageFrame>
    with AutomaticKeepAliveClientMixin<_StoryPageFrame> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<StoriesBloc, StoriesState>(builder: (context, state) {
      return Stack(
        alignment: Alignment.topLeft,
        children: [
          Positioned.fill(
            child: ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),

          //OBX
          Positioned.fill(
            child: widget.itemBuilder(
              context,
              widget.pageIndex,
              widget.pageIndex == state.currentPageIndex
                  ? state.currentStackIndex
                  : 0,
            ),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 10,
                  blurRadius: 20,
                ),
              ],
            ),
          ),
          Indicators(
            storyLength: widget.storyLength,
            isCurrentPage: widget.isCurrentPage,
            isPaging: widget.isPaging,
            indicatorAnimationValue: widget.indicatorAnimationValue,
          ),
          Gestures(),
          Positioned.fill(
            child: Stack(
              children: [
                Align(
                  alignment: !(Directionality.of(context) == TextDirection.rtl)
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      color: Colors.white,
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        AppRouter.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}

typedef StoryItemBuilder = Widget Function(
  BuildContext context,
  int pageIndex,
  int storyIndex,
);

typedef StoryConfigFunction = int Function(int pageIndex);

enum IndicatorAnimationCommand { pause, resume }
