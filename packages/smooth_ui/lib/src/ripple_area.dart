import 'package:flutter/widgets.dart';

import 'ripple.dart';
import 'utils.dart';

class RippleAreaPainter extends RipplePainter {
  const RippleAreaPainter({super.center, super.ratio, required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (ratio == 0) return;
    final radius = size.longerThanDiagonal * ratio;
    final paint = Paint()..color = color;
    canvas
      ..clipRect(size.toRectFill)
      ..drawCircle(center, radius, paint);
  }
}
