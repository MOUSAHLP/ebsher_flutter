import 'dart:developer';

import 'package:absher/bloc/stories_bloc/stories_bloc.dart';
import 'package:absher/bloc/stories_bloc/stories_event.dart';
import 'package:absher/core/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Gestures extends StatelessWidget {
  const Gestures({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var storiesBloc = context.read<StoriesBloc>();
    return Padding(
      padding: EdgeInsets.only(
        bottom: 40,
        top: 80,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  storiesBloc.add(CurrentStackDecrement());
                },
                onLongPress: () {
                  storiesBloc.animationController.stop();
                },
                onLongPressUp: () {
                  storiesBloc.animationController.forward();
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  log('Tapped INcress');
                  storiesBloc.add(CurrentStackIncrement());
                },
                onTapDown: (details) {
                  storiesBloc.animationController.stop();
                  storiesBloc.playerController?.pause();
                },
                onTapCancel: () {
                  storiesBloc.animationController.forward();
                  storiesBloc.playerController?.play();
                },
                onLongPressStart: (_) {
                  storiesBloc.animationController.stop();
                  storiesBloc.playerController?.pause();
                },
                onLongPress: () {
                  storiesBloc.animationController.stop();
                  storiesBloc.playerController?.pause();
                },
                onLongPressUp: () {
                  storiesBloc.animationController.forward();
                  storiesBloc.playerController?.play();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
