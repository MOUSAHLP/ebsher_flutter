import 'dart:math';

import 'package:absher/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

const int _defaultDashes = 2;
const Color _defaultColor = ColorManager.softYellow;
const double _defaultGapSize = 3.0;
const double _defaultStrokeWidth = 3;

class DashedCircle extends StatelessWidget {
  final int dashes;
  final Color color;
  final double gapSize;
  final double strokeWidth;
  final Widget? child;

  const DashedCircle({
    super.key,
    this.child,
    this.dashes = _defaultDashes,
    this.color = _defaultColor,
    this.gapSize = _defaultGapSize,
    this.strokeWidth = _defaultStrokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    if (dashes == 1) {
      return FullCircle(
        strokeWidth: strokeWidth,
        color: color,
        child: child!,
      );
    } else {
      return CustomPaint(
        painter: DashedCirclePainter(
          dashes: dashes,
          color: color,
          gapSize: gapSize,
          strokeWidth: strokeWidth,
        ),
        child: child,
      );
    }
  }
}

class FullCircle extends StatelessWidget {
  const FullCircle({
    required this.child,
    required this.color,
    required this.strokeWidth,
    Key? key,
  }) : super(key: key);
  final Widget child;
  final double strokeWidth;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: Border.all(color: color, width: strokeWidth),
      ),
      child: child,
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  final int dashes;
  final Color color;
  final double gapSize;
  final double strokeWidth;

  DashedCirclePainter({
    this.dashes = _defaultDashes,
    this.color = _defaultColor,
    this.gapSize = _defaultGapSize,
    this.strokeWidth = _defaultStrokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double gap = pi / 180 * gapSize;
    final double singleAngle = (pi * 2) / dashes;

    for (int i = 0; i < dashes; i++) {
      final Paint paint = Paint()
        ..color = i == 1 ? Colors.grey : color
        ..strokeWidth = _defaultStrokeWidth
        ..style = PaintingStyle.stroke;

      canvas.drawArc(
        Offset.zero & size,
        gap + singleAngle * i,
        singleAngle - gap * 2,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(DashedCirclePainter oldDelegate) {
    return dashes != oldDelegate.dashes || color != oldDelegate.color;
  }
}
