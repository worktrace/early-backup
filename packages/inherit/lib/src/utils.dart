import 'package:bang_lerp/bang_lerp.dart';
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
