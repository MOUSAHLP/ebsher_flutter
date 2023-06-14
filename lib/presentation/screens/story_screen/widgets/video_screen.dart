import 'dart:developer';

import 'package:absher/bloc/stories_bloc/stories_bloc.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

import '../../../resources/font_app.dart';
import '../../../resources/style_app.dart';

class VideoStory extends StatelessWidget {
  const VideoStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class VideoScreen extends StatefulWidget {
  const VideoScreen({
    Key? key,
    required this.videoUrl,
    required this.animationController,
    required this.isCurrentStory,
  }) : super(key: key);
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
    widget.animationController.stop();
    storiesBloc = context.read<StoriesBloc>();
    _initController(widget.videoUrl);
    super.initState();
  }

  void _initController(String link) {
    setState(() {
      print('init state');
      isLoading = true;
      error = false;
    });

    storiesBloc.playerController = VideoPlayerController.network(link);

    storiesBloc.playerController!.initialize().then((_) {
      print('initialized');
      setState(() {
        isLoading = false;
      });
      if (widget.isCurrentStory) {
        log('in current if ');
        widget.animationController.duration =
            storiesBloc.playerController!.value.duration;
        widget.animationController.forward();
        storiesBloc.playerController?.play();
        setState(() {});
      }
      log('after current if ');
      storiesBloc.playerController!.addListener(() {
        if (storiesBloc.playerController!.value.hasError) {
          print('HasError');
          widget.animationController.duration = Duration(seconds: 5);
          widget.animationController.forward();
          setState(() {
            error = true;
          });
        }
      });
    }).catchError((onError) {
      widget.animationController.duration = Duration(seconds: 5);
      widget.animationController.forward();
      setState(() {
        error = true;
      });
    });
  }

  void resetPlayer() {
    widget.animationController.stop();
    final oldController = storiesBloc.playerController;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await oldController?.dispose();
      _initController(widget.videoUrl);
    });
  }

  @override
  void didUpdateWidget(VideoScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      resetPlayer();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!storiesBloc.playerController!.value.isInitialized && !error) {
      storiesBloc.animationController.stop();
    }

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
                    AppLocalizations.of(context)!.error,
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
                  if (storiesBloc.playerController != null &&
                      !storiesBloc.playerController!.value.isPlaying)
                    Column(
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
                    ),
                ],
              ),
      ),
    );
  }
}
