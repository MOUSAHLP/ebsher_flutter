
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class VideoThumbImage extends StatefulWidget {
  const VideoThumbImage({Key? key, required this.videoUrl}) : super(key: key);
  final String videoUrl;
  @override
  State<VideoThumbImage> createState() => _VideoThumbImageState();
}

class _VideoThumbImageState extends State<VideoThumbImage> {
  late VideoPlayerController _controller;
  bool error = false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.addListener(() {
      if (_controller.value.hasError) {
        setState(() {
          error = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (error) {
      return const Icon(
        Icons.error_outline,
        color: Colors.white,
        size: 34,
      );
    }
    return _controller.value.isInitialized
        ? SizedBox(
            height: 6.h,
            width: 6.h,
            child: VideoPlayer(_controller),
          )
        : const CircularProgressIndicator(
            color: Colors.white,
          );
  }
}
