import 'package:flutter/widgets.dart';

class RippleState {
  const RippleState({required this.center, this.ratio = 0});

  final Offset center;
  final double ratio;
}

abstract class RipplePainter extends CustomPainter {
  const RipplePainter({required this.state, required this.color});

  final RippleState state;
  final Color color;

  @override
  bool shouldRepaint(covariant RipplePainter oldDelegate) {
    return state != oldDelegate.state || color != oldDelegate.color;
  }
}
