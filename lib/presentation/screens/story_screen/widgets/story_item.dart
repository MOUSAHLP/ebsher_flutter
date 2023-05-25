import 'dart:developer';

import 'package:absher/bloc/stories_bloc/stories_bloc.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/story_screen/widgets/video_screen.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoryItem extends StatefulWidget {
  final int storyIndex;
  final int pageIndex;

  const StoryItem({required this.storyIndex, required this.pageIndex, Key? key})
      : super(key: key);

  @override
  State<StoryItem> createState() => _StoryItemState();
}

class _StoryItemState extends State<StoryItem> {
  @override
  Widget build(BuildContext context) {
    var storiesBloc = context.read<StoriesBloc>();
    return Stack(
      children: [
        Positioned.fill(
          child: Container(color: Colors.black),
        ),
        if (storiesBloc
                .stories[widget.pageIndex].stories![widget.storyIndex].video !=
            null)
          Positioned.fill(
            child: storiesBloc.state.currentPageIndex == widget.pageIndex
                ? VideoScreen(
                    videoUrl: storiesBloc.stories[widget.pageIndex]
                        .stories![widget.storyIndex].video!,
                    animationController: storiesBloc.animationController,
                    isCurrentStory: storiesBloc.state.currentStackIndex ==
                            widget.storyIndex &&
                        storiesBloc.state.currentPageIndex == widget.pageIndex,
                  )
                : Container(),
          ),
        if (storiesBloc
                .stories[widget.pageIndex].stories![widget.storyIndex].video ==
            null)
          Positioned.fill(
            child: ExtendedImage.network(
              storiesBloc.stories[widget.pageIndex].stories![widget.storyIndex]
                      .image ??
                  '',
              fit: BoxFit.contain,
              cacheMaxAge: const Duration(days: 2),
              clearMemoryCacheWhenDispose: true,
              handleLoadingProgress: true,
              cache: true,
              loadStateChanged: (ExtendedImageState state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    storiesBloc.animationController.stop();
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  case LoadState.completed:
                    storiesBloc.animationController.forward();
                    return state.completedWidget;
                  case LoadState.failed:
                    storiesBloc.animationController.forward();
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.white,
                          size: 32,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'حدث خطأ ما.',
                          style: getBoldStyle(
                            color: Colors.white,
                            fontSize: FontSizeApp.s16,
                          ),
                        )
                      ],
                    );
                }
              },
            ),
          ),
      ],
    );
  }
}
