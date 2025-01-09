import 'package:auto_stories/auto_stories.dart';
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
