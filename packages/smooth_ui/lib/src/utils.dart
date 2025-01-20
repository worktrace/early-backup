import 'package:avoid_nullable/avoid_nullable.dart';
import 'package:flutter/widgets.dart';

class AreaColors {
  const AreaColors({
    this.background = const Color(0x00000000),
    this.foreground,
  });

  factory AreaColors.lerp(AreaColors a, AreaColors b, double t) {
    return AreaColors(
      background: lerpColor(a.background, b.background, t),
      foreground: Color.lerp(a.foreground, b.foreground, t),
    );
  }

  final Color background;
  final Color? foreground;
}

extension SizeUtils on Size {
  Rect get toRectFill => Rect.fromLTWH(0, 0, width, height);
  Rect toRect(Offset offset) {
    return Rect.fromLTWH(offset.dx, offset.dy, width, height);
  }
}

extension RadiusConvert on Radius {
  /// Whether x == y.
  bool get isSquare => x == y;

  /// Equals x / y.
  double get ratio => x / y;

  /// Equals y / x.
  double get ratioInverse => y / x;
}
