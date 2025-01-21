import 'package:flutter/widgets.dart';
import 'package:wrap/wrap.dart';

abstract class RipplePainter extends CustomPainter {
  const RipplePainter({
    this.center = Offset.zero,
    this.radius = 0,
    this.color = transparent,
  });

  final Offset center;
  final double radius;
  final Color color;

  @override
  bool shouldRepaint(covariant RipplePainter oldDelegate) =>
      center != oldDelegate.center ||
      radius != oldDelegate.radius ||
      color != oldDelegate.color;
}
