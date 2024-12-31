import 'package:auto_stories/auto_stories.dart';
import 'package:flutter/widgets.dart';

class ColorTheme extends ColorThemeBase {
  const ColorTheme.light({
    super.brightness,
    super.foreground = Colors.ink,
    super.background = Colors.snow,
  }) : super.light();

  const ColorTheme.dark({
    super.brightness,
    super.foreground = Colors.lunar,
    super.background = Colors.coal,
  }) : super.dark();

  factory ColorTheme.lerp(ColorTheme a, ColorTheme b, double t) {
    return ColorTheme.light(
      brightness: t < 0.5 ? a.brightness : b.brightness,
      foreground: Color.lerp(a.foreground, b.foreground, t),
      background: lerpColor(a.background, b.background, t),
    );
  }

  static ColorThemeAdapter<ColorTheme> adapter({
    ColorThemeMode mode = ColorThemeMode.system,
  }) {
    return ColorThemeAdapter(
      light: const ColorTheme.light(),
      dark: const ColorTheme.dark(),
      mode: mode,
    );
  }
}
