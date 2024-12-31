import 'package:flutter/widgets.dart';

import 'animation.dart';

extension SizeUtils on Size {
  Rect get toRectFill => Rect.fromLTWH(0, 0, width, height);
  Rect toRect(Offset offset) {
    return Rect.fromLTWH(offset.dx, offset.dy, width, height);
  }
}

/// Computed value of golden ratio (sqrt(5) - 1) / 2.
const double goldenRatio = _goldenRatio;

// Avoid name conflict.
const _goldenRatio = 0.6180339887498949;

extension DoubleConvert on double {
  double get square => this * this;
  double get goldenRatio => this * _goldenRatio;
}

extension RadiusConvert on Radius {
  /// Whether x == y.
  bool get isSquare => x == y;

  /// Equals x / y.
  double get ratio => x / y;

  /// Equals y / x.
  double get ratioInverse => y / x;
}

Radius lerpRadius(Radius a, Radius b, double t) {
  return Radius.elliptical(lerpDouble(a.x, b.x, t), lerpDouble(a.y, b.y, t));
}

BorderRadius lerpBorderRadius(BorderRadius a, BorderRadius b, double t) {
  return BorderRadius.only(
    topLeft: lerpRadius(a.topLeft, b.topLeft, t),
    topRight: lerpRadius(a.topRight, b.topRight, t),
    bottomLeft: lerpRadius(a.bottomLeft, b.bottomLeft, t),
    bottomRight: lerpRadius(a.bottomRight, b.bottomRight, t),
  );
}
