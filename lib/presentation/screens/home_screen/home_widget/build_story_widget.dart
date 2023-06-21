import 'package:absher/bloc/home_bloc/home_bloc.dart';
import 'package:absher/bloc/stories_bloc/stories_bloc.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/widgets/accessories/cached_image.dart';
import 'package:absher/presentation/widgets/accessories/video_thumb_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../bloc/home_bloc/home_event.dart';
import '../../../../bloc/home_bloc/home_state.dart';
import '../../../../core/services/services_locator.dart';
import '../../../resources/values_app.dart';
import '../../../widgets/animated_container.dart';
import '../../story_screen/story_screen.dart';

class BuildStoryWidget extends StatelessWidget {
  const BuildStoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8.9.h,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: context.read<HomeBloc>().stories!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return OpenContainerWithFade(
            page: StoryScreen(
              targetPageIndex: index,
              stories: context.read<HomeBloc>().stories!,
            ),
            cardItem: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Stack(
                children: [
                  Container(
                    height: 7.7.h,
                    width: 7.7.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[
                          ColorManager.circleStartColor,
                          ColorManager.circleEndColor,
                        ],
                      ),
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(RadiusApp.r50),
                        child: CachedImage(
                          height: 6.h,
                          width: 6.h,
                          imageUrl: context
                              .read<HomeBloc>()
                              .stories![index]
                              .stories![0]
                              .image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    bloc: sl<HomeBloc>()..add(ChangeSeeStory([])),
                    builder: (context, state) {
                      return context
                                  .read<HomeBloc>()
                                  .stories![index]
                                  .stories![0]
                                  .seen ==
                              "0"
                          ? Container(
                              height: 10,
                              width: 10,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ))
                          : SizedBox.shrink();
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
