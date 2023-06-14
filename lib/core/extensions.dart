import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

extension Rotate on Widget {
  Widget handleRotation(BuildContext context) {
    bool isRtl = Directionality.of(context) == TextDirection.rtl;
    if (isRtl) {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(math.pi),
        child: this,
      );
    } else {
      return this;
    }
  }

  Widget handleRotationOwn(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: this,
    );
  }
}
