import 'dart:developer';

import 'package:absher/bloc/stories_bloc/stories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

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
  // VideoPlayerController? playerController;
  late StoriesBloc storiesBloc;
  bool isLoading = true;
  @override
  void initState() {
    log('init Called');
    storiesBloc = context.read<StoriesBloc>();
    _startVideoPlayer(widget.videoUrl);
    super.initState();
  }

  void _initController(String link) {
    storiesBloc.playerController = VideoPlayerController.network(link)
      ..initialize().then((_) {
        if (widget.isCurrentStory) {
          widget.animationController.stop();
          storiesBloc.playerController!.addListener(() {
            if (storiesBloc.playerController!.value.isBuffering) {
              isLoading = true;
              widget.animationController.stop();
            } else {
              isLoading = false;
            }
            widget.animationController.value =
                storiesBloc.playerController!.value.position.inMilliseconds /
                    storiesBloc.playerController!.value.duration.inMilliseconds;
          });
          storiesBloc.playerController?.play();
          setState(() {});
        }
      });
  }

  Future<void> _startVideoPlayer(String link) async {
    if (storiesBloc.playerController == null) {
      _initController(link);
    } else {
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
    // widget.animationController.value = 0;
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

  @override
  void dispose() {
    storiesBloc.playerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Stack(
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
                SpinKitCircle(
                  color: Colors.white,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
