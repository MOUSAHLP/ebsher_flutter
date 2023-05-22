import 'dart:developer';

import 'package:absher/bloc/stories_bloc/stories_bloc.dart';
import 'package:absher/bloc/stories_bloc/stories_event.dart';
import 'package:absher/bloc/stories_bloc/stories_state.dart';
import 'package:absher/presentation/screens/story_screen/story_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Indicators extends StatefulWidget {
  const Indicators({
    Key? key,
    required this.storyLength,
    required this.isCurrentPage,
    required this.isPaging,
  }) : super(key: key);
  final int storyLength;
  final bool isCurrentPage;
  final bool isPaging;

  @override
  _IndicatorsState createState() => _IndicatorsState();
}

class _IndicatorsState extends State<Indicators> with TickerProviderStateMixin {
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;
  late AnimationController animationController;
  late VoidCallback listener;
  late Animation<double> indicatorAnimation;

  double indicatorAnimationValue = 0;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            log('animation Compl');
            log(animationController.value.toString());
            context.read<StoriesBloc>().add(CurrentStackIncrement());
          }
        },
      )
      ..addListener(() {
        if (animationController.value == 1) {}
      });

    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
      IndicatorAnimationCommand.resume,
    );

    listener = () {
      switch (indicatorAnimationController.value) {
        case IndicatorAnimationCommand.pause:
          animationController.stop();
          break;
        case IndicatorAnimationCommand.resume:
        default:
          animationController.forward();
          break;
      }
    };

    indicatorAnimationController.addListener(listener);

    indicatorAnimation =
        Tween(begin: 0.0, end: 1.0).animate(animationController)
          ..addListener(() {
            setState(() {
              indicatorAnimationValue = indicatorAnimation.value;
            });
          });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoriesBloc, StoriesState>(
      listener: (context, state) {
        if (state.isForward) {
          animationController.forward(from: state.forwardFrom);
        }
        if (state.isStop) {
          animationController.stop();
        }
        if (state.value != null) {
          animationController.value = state.value!;
        }
      },
      listenWhen: (p, c) {
        if (p.forwardFrom != c.forwardFrom) return true;
        if (p.isForward != c.isForward) return true;
        if (p.value != c.value) return true;
        if (p.isStop != c.isStop) return true;
        return false;
      },
      builder: (context, state) {
        if (!widget.isCurrentPage && widget.isPaging) {
          context.read<StoriesBloc>().add(OnAnimationChange(isStop: true));
        }
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 8,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              widget.storyLength,
              (index) {
                if (indicatorAnimationValue < 2) {
                  return _Indicator(
                    index: index,
                    value: (index == state.currentStackIndex)
                        ? indicatorAnimationValue
                        : (index > state.currentStackIndex)
                            ? 0
                            : 1,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        );
      },
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    Key? key,
    required this.index,
    required this.value,
  }) : super(key: key);
  final int index;
  final double value;

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: (index == 0 || isRtl) ? 0 : 4,
          right: (index == 0 || !isRtl) ? 0 : 4,
        ),
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.grey[700],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          minHeight: 3,
        ),
      ),
    );
  }
}
