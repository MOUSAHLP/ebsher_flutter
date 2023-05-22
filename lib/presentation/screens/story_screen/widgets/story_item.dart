import 'dart:developer';

import 'package:absher/bloc/stories_bloc/stories_bloc.dart';
import 'package:absher/bloc/stories_bloc/stories_event.dart';
import 'package:absher/core/services/services_locator.dart';
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
        Positioned.fill(
          child: Hero(
            tag: DateTime.now().toString(),
            // child: Image.network(
            //   storiesBloc.stories![widget.pageIndex].stories![widget.storyIndex]
            //           .image ??
            //       '',
            //   frameBuilder: (BuildContext context, Widget child, int? frame,
            //       bool? wasSynchronouslyLoaded) {
            //     if (wasSynchronouslyLoaded == true) {
            //       // storiesBloc.add(OnAnimationChange(isForward: true));
            //     }
            //     return Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: child,
            //     );
            //   },
            //   loadingBuilder: (BuildContext context, Widget child,
            //       ImageChunkEvent? loadingProgress) {
            //     // storiesBloc.add(OnAnimationChange(isStop: true));
            //     return Center(child: child);
            //   },
            // ),
            child: ExtendedImage.network(
              storiesBloc.stories![widget.pageIndex].stories![widget.storyIndex]
                      .image ??
                  '',
              fit: BoxFit.contain,
              // cacheMaxAge: const Duration(days: 2),
              clearMemoryCacheWhenDispose: true,
              handleLoadingProgress: true,
              cache: false,
              loadStateChanged: (ExtendedImageState state) {
                // storyController.storyAnimationStop();
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    storiesBloc.add(OnAnimationChange(isStop: true));
                    return Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        if (state.loadingProgress != null &&
                            state.loadingProgress!.expectedTotalBytes != null)
                          Center(
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.grey.withOpacity(0.3),
                              ),
                            ),
                          ),
                      ],
                    );

                  case LoadState.completed:
                    storiesBloc.add(OnAnimationChange(isForward: true));
                    return state.completedWidget;
                  case LoadState.failed:
                    storiesBloc.add(OnAnimationChange(isForward: true));
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Colors.white, Colors.grey[900]!],
                        ),
                      ),
                    );
                }
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 44, left: 8),
          child: GestureDetector(
            onTap: () {
              // storiesBloc.navigateToStoryRestaurant();
            },
            child: Row(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        storiesBloc.stories![widget.pageIndex].vendorLogo!,
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
                      storiesBloc.stories![widget.pageIndex].vendorName!,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Creation Time',
                      // PaprikaRelativeTime.timeAgoSinceDate(
                      //   context,
                      //   storyController.stories![widget.pageIndex]
                      //       .stories![widget.storyIndex].creationTime,
                      //   isPost: true,
                      // ),
                      style: const TextStyle(color: Colors.grey, height: 1),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // if (storiesBloc.stories![widget.pageIndex].stories![widget.storyIndex]
        //         .description !=
        //     null)
        //   Positioned(
        //     bottom: -1,
        //     child: Container(
        //       decoration: const BoxDecoration(
        //         gradient: LinearGradient(
        //           begin: Alignment.topCenter,
        //           end: Alignment.bottomCenter,
        //           colors: <Color>[
        //             Colors.black38,
        //             Colors.black12,
        //             Colors.black38,
        //             Colors.black54,
        //             Colors.black
        //           ],
        //         ),
        //         borderRadius: BorderRadius.only(
        //           topLeft: Radius.circular(20),
        //           topRight: Radius.circular(20),
        //         ),
        //       ),
        //       child: SizedBox(
        //         width: MediaQuery.of(context).size.width,
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.end,
        //             children: [
        //               SizedBox(
        //                 // height: storiesBloc.descExpanded
        //                 //     ? storiesBloc.descHeight + 20
        //                 //     : 60,
        //                 child: Column(
        //                   children: [
        //                     Expanded(
        //                       child: SingleChildScrollView(
        //                         physics:
        //                             // storiesBloc.descExpanded
        //                             //     ? const AlwaysScrollableScrollPhysics()
        //                             //     : const
        //                             NeverScrollableScrollPhysics(),
        //                         child: Center(
        //                           child: Text(
        //                             storiesBloc
        //                                 .stories![widget.pageIndex]
        //                                 .stories![widget.storyIndex]
        //                                 .description!,
        //                             // maxLines:
        //                             //     storiesBloc.descExpanded ? null : 3,
        //                             // overflow: storiesBloc.descExpanded
        //                             //     ? null
        //                             //     : TextOverflow.ellipsis,
        //                             style: const TextStyle(
        //                               color: Colors.white,
        //                               fontSize: 14,
        //                             ),
        //                             textAlign: TextAlign.center,
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //               if (storiesBloc.stories![widget.pageIndex]
        //                       .stories![widget.storyIndex].description !=
        //                   null
        //               // &&
        //               // hasTextOverflow(
        //               //   storyController.stories![widget.pageIndex]
        //               //       .stories![widget.storyIndex].description!,
        //               //   const TextStyle(
        //               //     color: Colors.white,
        //               //     fontSize: 14,
        //               //   ),
        //               //   maxWidth: Get.width,
        //               // )
        //               )
        //                 GestureDetector(
        //                   child: Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Text(
        //                       // storiesBloc.descExpanded
        //                       //     ? 'See less'
        //                       //     : "See More",
        //                       'seeLess',
        //                       style: TextStyle(
        //                         color: Theme.of(context).primaryColor,
        //                       ),
        //                     ),
        //                   ),
        //                   onTap: () {
        //                     setState(() {
        //                       // storiesBloc.descExpanded =
        //                       //     !storiesBloc.descExpanded;
        //                       // storiesBloc.getPreferedDescHeight();
        //                       // if (storiesBloc.descExpanded) {
        //                       //   storiesBloc.animationController.stop();
        //                       // } else {
        //                       //   storiesBloc.animationController.forward();
        //                       // }
        //                     });
        //                   },
        //                 )
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
      ],
    );
  }
}
