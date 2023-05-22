import 'package:absher/bloc/stories_bloc/stories_bloc.dart';
import 'package:absher/bloc/stories_bloc/stories_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Indicators extends StatefulWidget {
  const Indicators({
    Key? key,
    required this.storyLength,
    required this.isCurrentPage,
    required this.isPaging,
    required this.indicatorAnimationValue,
  }) : super(key: key);
  final int storyLength;
  final bool isCurrentPage;
  final bool isPaging;
  final double indicatorAnimationValue;

  @override
  _IndicatorsState createState() => _IndicatorsState();
}

class _IndicatorsState extends State<Indicators> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StoriesBloc storiesBloc = context.read<StoriesBloc>();
    return BlocBuilder<StoriesBloc, StoriesState>(
      builder: (context, state) {
        if (!widget.isCurrentPage && widget.isPaging) {
          storiesBloc.animationController.stop();
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
                if (widget.indicatorAnimationValue < 2) {
                  return _Indicator(
                    index: index,
                    value: (index == state.currentStackIndex)
                        ? widget.indicatorAnimationValue
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
