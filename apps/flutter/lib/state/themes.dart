import 'package:auto_stories/auto_stories.dart';

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
