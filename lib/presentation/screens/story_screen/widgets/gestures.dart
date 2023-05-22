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
        // bottom: 40 + (storiesBloc.descExpanded ? storiesBloc.descHeight : 0),
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
                  // storiesBloc.add(OnAnimationChange(isForward: true));
                  storiesBloc.add(CurrentStackDecrement());
                },
                onLongPress: () {
                  storiesBloc.animationController.stop();
                },
                onLongPressUp: () {
                  storiesBloc.add(OnAnimationChange(isForward: true));
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
                  log('pressed');
                  // storiesBloc.add(OnAnimationChange(isForward: true));
                  storiesBloc.add(CurrentStackIncrement());
                  // storiesBloc
                  //     .add(OnAnimationChange(isForward: true, forwardFrom: 1));
                },
                onTapDown: (details) {
                  log('onTapDown');
                  storiesBloc.animationController.stop();
                },
                onTapCancel: () {
                  log('onTapCancel');
                  storiesBloc.animationController.forward();
                },
                onLongPressStart: (_) {
                  log('onLongPressStart');
                  storiesBloc.animationController.stop();
                },
                onLongPress: () {
                  log('onLongPress');
                  storiesBloc.animationController.stop();
                },
                onLongPressUp: () {
                  log('onLongPressUp');
                  storiesBloc.animationController.forward();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
