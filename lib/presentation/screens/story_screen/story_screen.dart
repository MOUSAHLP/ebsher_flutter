import 'dart:math';
import 'dart:ui';
import 'dart:developer' as dev;

import 'package:absher/bloc/stories_bloc/stories_bloc.dart';
import 'package:absher/bloc/stories_bloc/stories_event.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/core/services/services_locator.dart';
import 'package:intl/intl.dart' as intl;
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/story_screen/widgets/gestures.dart';
import 'package:absher/presentation/screens/story_screen/widgets/indicators.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/stories_bloc/stories_state.dart';
import '../../../core/localization_string.dart';
import '../../../core/relative_time.dart';
import '../../../models/story_model.dart';
import 'widgets/story_item.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen(
      {Key? key, required this.targetPageIndex, required this.stories})
      : super(key: key);
  final int targetPageIndex;
  final List<StoryModelDto> stories;

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StoriesBloc>(
      create: (BuildContext context) =>
          StoriesBloc()..init(widget.stories, widget.targetPageIndex),
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
    storiesBloc.playerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () {
        AppRouter.pop(context);
      },
      key: const Key(''),
      child: BlocConsumer<StoriesBloc, StoriesState>(
        listener: (context, state) {
          if (state is ExitStories) {
            AppRouter.pop(context);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: ColoredBox(
              color: Colors.transparent,
              child: PageView.builder(
                controller: storiesBloc.pageController,
                itemCount: storiesBloc.stories.length,
                onPageChanged: (newPageIndex) {
                  context
                      .read<StoriesBloc>()
                      .add(OnStoryPageChanged(index: newPageIndex));
                },
                itemBuilder: (context, index) {
                  final isLeaving = (index - state.currentPageValue) <= 0;
                  final t = index - state.currentPageValue;
                  final rotationY = storiesBloc.pageController!.initialPage ==
                          index
                      ? lerpDouble(0, 0, t)!
                      : lerpDouble(
                          0,
                          Localizations.localeOf(context).languageCode == 'en'
                              ? 40
                              : -40,
                          t)!;
                  const maxOpacity = 0.8;
                  final num opacity = lerpDouble(0, maxOpacity, t.abs())!
                      .clamp(0.0, maxOpacity);
                  final isPaging = opacity != maxOpacity;
                  final transform = Matrix4.identity();
                  transform.setEntry(3, 2, 0.003);
                  transform.rotateY(-rotationY * (pi / 180.0));
                  return Transform(
                    alignment:
                        Localizations.localeOf(context).languageCode == 'en'
                            ? isLeaving
                                ? Alignment.centerRight
                                : Alignment.centerLeft
                            : !isLeaving
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                    transform: transform,
                    child: _StoryPageFrame(
                      storyLength: storiesBloc.stories[index].stories!.length,
                      pageIndex: index,
                      animateToPage: (index) {
                        storiesBloc.pageController!.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      isCurrentPage: state.currentPageIndex == index,
                      isPaging: isPaging,
                      itemBuilder: (context, pageIndex, storyIndex) {
                        return StoryItem(
                          storyIndex: storyIndex,
                          pageIndex: pageIndex,
                        );
                      },
                      indicatorAnimationValue: indicatorAnimationValue,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
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
    Key? key,
    required this.indicatorAnimationValue,
  }) : super(key: key);

  final int pageIndex;
  final ValueChanged<int> animateToPage;
  final int storyLength;
  final bool isCurrentPage;
  final bool isPaging;
  final StoryItemBuilder itemBuilder;
  final double indicatorAnimationValue;

  @override
  State<_StoryPageFrame> createState() => _StoryPageFrameState();
}

class _StoryPageFrameState extends State<_StoryPageFrame> {
  // @override
  // bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoriesBloc, StoriesState>(builder: (context, state) {
      return Stack(
        alignment: Alignment.topLeft,
        children: [
          Positioned.fill(
            child: widget.itemBuilder(
              context,
              widget.pageIndex,
              widget.pageIndex == state.currentPageIndex
                  ? state.currentStackIndex
                  : 0,
            ),
          ),
          Column(
            children: [
              Indicators(
                storyLength: widget.storyLength,
                isCurrentPage: widget.isCurrentPage,
                isPaging: widget.isPaging,
                indicatorAnimationValue: widget.indicatorAnimationValue,
              ),
              context
                  .read<StoriesBloc>()
                  .stories[widget.pageIndex].vendor!.isEmpty?SizedBox():    Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        // storiesBloc.navigateToStoryRestaurant();
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  context
                                      .read<StoriesBloc>()
                                      .stories[widget.pageIndex].vendor![0].image!,
                                ),
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
      LocalixationString(context, context
          .read<StoriesBloc>()
          .stories[widget.pageIndex]
          .vendor![0].name!) ?? ""
                               ,
                                style: getBoldStyle(
                                  color: Colors.white,
                                  fontSize: FontSizeApp.s18,
                                )!
                                    .copyWith(height: 1.2),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Text(
                                    RelativeTime.relativeTime(
                                        context,
                                        context
                                            .read<StoriesBloc>()
                                            .stories[widget.pageIndex]
                                            .stories![widget.isCurrentPage
                                                ? context
                                                    .read<StoriesBloc>()
                                                    .state
                                                    .currentStackIndex
                                                : 0]
                                            .createdAt),
                                    style: getBoldStyle(
                                      color: Colors.white,
                                      fontSize: FontSizeApp.s12,
                                    )!
                                        .copyWith(height: 1.6),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(28),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            intl.NumberFormat.compact().format(
                                                context
                                                    .read<StoriesBloc>()
                                                    .stories[widget.pageIndex]
                                                    .views),
                                            style: getBoldStyle(
                                              color: ColorManager.softYellow,
                                            )!
                                                .copyWith(height: 1),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Icon(
                                            Icons.remove_red_eye,
                                            color: ColorManager.softYellow,
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      color: Colors.white,
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        AppRouter.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gestures(),
          if (context
                  .read<StoriesBloc>()
                  .stories[widget.pageIndex]
                  .stories![widget.isCurrentPage
                      ? context.read<StoriesBloc>().state.currentStackIndex
                      : 0]
                  .description !=
              null)
            Positioned(
              bottom: -1,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.black12,
                      Colors.black38,
                      Colors.black38,
                      Colors.black54,
                      Colors.black
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      context
                          .read<StoriesBloc>()
                          .stories[widget.pageIndex]
                          .stories![widget.isCurrentPage
                              ? context
                                  .read<StoriesBloc>()
                                  .state
                                  .currentStackIndex
                              : 0]
                          .description!,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}

typedef StoryItemBuilder = Widget Function(
  BuildContext context,
  int pageIndex,
  int storyIndex,
);

enum IndicatorAnimationCommand { pause, resume }
