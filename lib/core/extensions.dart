import 'package:flutter/cupertino.dart';

extension Rotate on Widget {
  Widget handleRotation(BuildContext context) {
    bool isRtl = Directionality.of(context) == TextDirection.rtl;
    return RotatedBox(
      quarterTurns: isRtl ? 2 : 4,
      child: this,
    );
  }
}
