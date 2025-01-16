import 'package:auto_stories/kit.dart';
import 'package:flutter/widgets.dart';

class Theme extends ThemeBase {
  const Theme.light({
    super.brightness,
    super.foreground = Colors.ink,
    super.background = Colors.snow,
  }) : super.light();

  const Theme.dark({
    super.brightness,
    super.foreground = Colors.lunar,
    super.background = Colors.coal,
  }) : super.dark();

  factory Theme.lerp(Theme a, Theme b, double t) {
    return Theme.light(
      brightness: t < 0.5 ? a.brightness : b.brightness,
      foreground: Color.lerp(a.foreground, b.foreground, t),
      background: lerpColor(a.background, b.background, t),
    );
  }

  static ThemeAdapter<Theme> adapter({
    ThemeMode mode = ThemeMode.system,
  }) {
    return ThemeAdapter(
      light: const Theme.light(),
      dark: const Theme.dark(),
      mode: mode,
    );
  }
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
