import 'dart:developer';

import 'package:absher/bloc/stories_bloc/stories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

import '../../../resources/font_app.dart';
import '../../../resources/style_app.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({
    Key? key,
    required this.indicatorVideoValue,
    required this.videoUrl,
    required this.animationController,
    required this.isCurrentStory,
  }) : super(key: key);
  final Function(double value) indicatorVideoValue;
  final String videoUrl;
  final AnimationController animationController;
  final bool isCurrentStory;
  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late StoriesBloc storiesBloc;
  bool isLoading = true;
  bool error = false;

  @override
  void initState() {
    log('init Called');
    storiesBloc = context.read<StoriesBloc>();
    _startVideoPlayer(widget.videoUrl);
    super.initState();
  }

  void _initController(String link) {
    setState(() {
      print('init state');
      isLoading = true;
      error = false;
    });
    // widget.animationController.stop();

    storiesBloc.playerController = VideoPlayerController.network(link);
    storiesBloc.playerController!.initialize().then((_) {
      print('initialized');
      isLoading = false;
      if (widget.isCurrentStory) {
        widget.animationController.duration =
            storiesBloc.playerController!.value.duration;
        widget.animationController.forward();
        storiesBloc.playerController?.play();
        setState(() {});
      }
      storiesBloc.playerController!.addListener(() {
        if (storiesBloc.playerController!.value.hasError) {
          widget.animationController.duration = Duration(seconds: 5);
          widget.animationController.forward();
          setState(() {
            error = true;
          });
        }
      });
    });
  }

  Future<void> _startVideoPlayer(String link) async {
    if (storiesBloc.playerController == null) {
      log('null video playercheck');
      _initController(link);
    } else {
      log(' else null video playercheck');
      final oldController = storiesBloc.playerController;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await oldController?.dispose();
        _initController(link);
      });
      setState(() {
        storiesBloc.playerController = null;
      });
    }
  }

  void resetPlayer() {
    widget.animationController.stop();
    final oldController = storiesBloc.playerController;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await oldController?.dispose();
      _startVideoPlayer(widget.videoUrl);
    });
  }

  @override
  void didUpdateWidget(VideoScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      resetPlayer();
    }
  }

  // @override
  // void dispose() {
  //   // storiesBloc.playerController?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: error
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(
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
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: storiesBloc.playerController != null
                        ? AspectRatio(
                            aspectRatio:
                                storiesBloc.playerController!.value.aspectRatio,
                            child: VideoPlayer(storiesBloc.playerController!))
                        : Container(),
                  ),
                  // if (storiesBloc.playerController != null &&
                  //     !storiesBloc.playerController!.value.isPlaying)
                  //   const SpinKitFoldingCube(
                  //     color: Colors.white,
                  //   ),
                ],
              ),
      ),
    );
  }
}
