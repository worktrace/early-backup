import 'package:flutter/widgets.dart';

import 'ripple.dart';
import 'utils.dart';

class RippleAreaPainter extends RipplePainter {
  const RippleAreaPainter({super.center, super.radius, super.color});

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..clipRect(size.toRectFill)
      ..drawCircle(center, radius, Paint()..color = color);
  }
}
