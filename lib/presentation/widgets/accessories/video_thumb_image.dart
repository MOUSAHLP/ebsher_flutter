import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

class VideoThumbImage extends StatefulWidget {
  const VideoThumbImage({Key? key, required this.videoUrl}) : super(key: key);
  final String videoUrl;
  @override
  State<VideoThumbImage> createState() => _VideoThumbImageState();
}

class _VideoThumbImageState extends State<VideoThumbImage> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {}); //when your thumbnail will show.
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _controller.value.isInitialized
          ? SizedBox(
              height: 60,
              width: 60,
              child: VideoPlayer(_controller),
            )
          : SpinKitCircle(
              color: Colors.white,
            ),
    );
  }
}
