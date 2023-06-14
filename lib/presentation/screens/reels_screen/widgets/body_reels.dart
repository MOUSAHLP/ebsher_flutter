import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/core/localization_string.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/widgets/accessories/cached_image.dart';
import 'package:absher/translations.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/relative_time.dart';
import '../../../../models/reels_model.dart';
import '../../../resources/font_app.dart';

// ignore: must_be_immutable
class BodyReelsScreen extends StatefulWidget {
  final ReelsModel? reelsModel;
  SwiperController? controller;

  BodyReelsScreen({Key? key, this.reelsModel, this.controller})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BodyReelsScreenState createState() => _BodyReelsScreenState();
}

class _BodyReelsScreenState extends State<BodyReelsScreen> {
  late VideoPlayerController _videoPlayerController;
  bool error = false;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future initializePlayer() async {
    _videoPlayerController =
        VideoPlayerController.network(widget.reelsModel!.video!);
    await Future.wait([_videoPlayerController.initialize()]);
    _videoPlayerController.play();
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.hasError) {
        widget.controller!.next(animation: true);
        setState(() {
          error = true;
        });
      }
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.controller!.next(animation: true);
      }
    });
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        _videoPlayerController.value.isInitialized
            ? error
                ? Center(
                  child: Column(
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
                         AppLocalizations.of(context)!.wrong,
                          style: getBoldStyle(
                            color: Colors.white,
                            fontSize: FontSizeApp.s16,
                          ),
                        )
                      ],
                    ),
                )
                : Center(
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _videoPlayerController.value.isPlaying
                              ? _videoPlayerController.pause()
                              : _videoPlayerController.play();
                        });
                      },
                      child: SizedBox(
                        width: 1.sw,
                        child: AspectRatio(
                          aspectRatio: _videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(
                            _videoPlayerController,
                          ),
                        ),
                      ),
                    ),
                )
            : Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                        color: ColorManager.primaryColor),
                    const SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context)!.loading,
                      style: getBoldStyle(color: Colors.white),
                    )
                  ],
                ),
            ),
        _videoPlayerController.value.isInitialized
            ? Center(
              child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      _videoPlayerController.value.isPlaying
                          ? _videoPlayerController.pause()
                          : _videoPlayerController.play();
                    });
                  },
                  child: Icon(
                    _videoPlayerController.value.isPlaying
                        ? null
                        : Icons.play_circle_fill,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
            )
            : const SizedBox.shrink(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 110),
                        Row(
                          children: [
                            Container(
                              height: 42,
                              width: 42,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CachedImage(
                                imageUrl: widget.reelsModel!.vendor!.image!,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              LocalixationString(context,  widget.reelsModel!.vendor!.name!)!
                             ,
                              style: getBoldStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(width: 6),
                        Text(widget.reelsModel!.description!,
                            style: getBoldStyle(color: Colors.white),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        widget.reelsModel!.views.toString(),
                        style: getBoldStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      const Icon(
                        Icons.timer,
                        color: Colors.white,
                      ),
                      Text(
                        RelativeTime.relativeTime(
                            context, widget.reelsModel!.createdAt),
                        style: getBoldStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(icon: Icon(Icons.clear,size: 30,color: Colors.white,),onPressed: (){
            AppRouter.pop(context);
          },),
        )
      ],
    );
  }
}
