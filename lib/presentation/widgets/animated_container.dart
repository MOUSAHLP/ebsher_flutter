import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class OpenContainerWithFade extends StatelessWidget {
   OpenContainerWithFade(
      {Key? key, required this.cardItem, required this.page})
      : super(key: key);
  final Widget cardItem;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionDuration: Duration(milliseconds: 500),
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext context, VoidCallback _) {
        return page;
      },
      openColor: Colors.transparent,
      closedColor: Colors.transparent,
      openElevation: 0,
      closedElevation: 0,
      onClosed: (value) {},
      tappable: false,
      closedBuilder: (BuildContext _, VoidCallback openContainer) {
        return SizedBox(
          child: InkWell(
            onTap: openContainer,
            child: cardItem,
          ),
        );
      },
    );
  }
}
