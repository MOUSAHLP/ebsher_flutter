import 'package:absher/bloc/home_bloc/home_bloc.dart';
import 'package:absher/bloc/stories_bloc/stories_bloc.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/widgets/accessories/cached_image.dart';
import 'package:absher/presentation/widgets/accessories/video_thumb_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../resources/values_app.dart';
import '../../../widgets/animated_container.dart';
import '../../story_screen/story_screen.dart';

class BuildStoreWidget extends StatelessWidget {
  const BuildStoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: ListView.builder(
        itemCount: context.read<HomeBloc>().stories!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return OpenContainerWithFade(
            page: StoryScreen(
              targetPageIndex: index,
              stories: context.read<HomeBloc>().stories!,
            ),
            cardItem: Padding(
              padding: const EdgeInsets.all(PaddingApp.p8),
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        ColorManager.circleStartColor,
                        ColorManager.circleEndColor,
                      ],
                    )),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(RadiusApp.r50),
                    child: context
                                .read<HomeBloc>()
                                .stories![index]
                                .stories![0]
                                .video ==
                            null
                        ? CachedImage(
                            height: 60,
                            width: 60,
                            imageUrl: context
                                .read<HomeBloc>()
                                .stories![index]
                                .stories![0]
                                .image,
                            fit: BoxFit.cover,
                          )
                        : VideoThumbImage(
                            videoUrl: context
                                .read<HomeBloc>()
                                .stories![index]
                                .stories![0]
                                .video!),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
