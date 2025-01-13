import 'package:bang_lerp/bang_lerp.dart';
import 'package:flutter/widgets.dart';

class AreaColors {
  const AreaColors({
    this.background = Colors.transparent,
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

abstract class Colors {
  // Transparent colors.
  static const transparent = Color(0x00000000);

  // Mono colors.
  static const snow = Color.fromARGB(255, 245, 247, 248);
  static const lunar = Color.fromARGB(255, 189, 188, 187);
  static const ink = Color.fromARGB(255, 49, 51, 52);
  static const coal = Color.fromARGB(255, 24, 23, 23);
}
