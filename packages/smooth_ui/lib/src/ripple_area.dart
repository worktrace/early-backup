import 'package:flutter/widgets.dart';

import 'ripple.dart';
import 'utils.dart';

class RippleAreaPainter extends RipplePainter {
  const RippleAreaPainter({super.center, super.ratio, super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.longerThanDiagonal * ratio;
    final paint = Paint()..color = color;
    canvas
      ..clipRect(size.toRectFill)
      ..drawCircle(center, radius, paint);
  }
}
