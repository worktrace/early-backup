import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:wrap/wrap.dart';

import 'ripple.dart';

class SingleRippleLinePainter extends RipplePainter {
  const SingleRippleLinePainter({
    required super.color,
    super.center,
    super.ratio,
    this.padding = EdgeInsets.zero,
  });

  final EdgeInsets padding;

  @override
  void paint(Canvas canvas, Size size) {
    if (ratio == 0) return;
    canvas.drawRRect(
      lineAreaOf(size, padding, center, ratio).capsule,
      Paint()..color = color,
    );
  }
}

Rect lineAreaOf(Size size, EdgeInsets padding, Offset center, double ratio) {
  return size.width > size.height
      ? _hArea(size, padding, center, ratio)
      : _vArea(size, padding, center, ratio);
}

Rect _hArea(Size size, EdgeInsets padding, Offset center, double ratio) {
  final c = center.dx;
  final radius = size.width * ratio;
  return Rect.fromLTRB(
    max(c - radius, padding.left),
    padding.top,
    min(c + radius, size.width - padding.right),
    size.height - padding.bottom,
  );
}

Rect _vArea(Size size, EdgeInsets padding, Offset center, double ratio) {
  final c = center.dy;
  final radius = size.height * ratio;
  return Rect.fromLTRB(
    padding.left,
    max(c - radius, padding.top),
    size.width - padding.right,
    min(c + radius, size.height - padding.bottom),
  );
}
