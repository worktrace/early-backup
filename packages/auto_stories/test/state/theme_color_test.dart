import 'package:auto_stories/auto_stories.dart';
import 'package:auto_stories/debug.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('adapt color theme mode', (t) async {
    t.binding.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    expect(ColorThemeMode.system.shouldDark, false);
    expect(ColorThemeMode.light.shouldDark, false);
    expect(ColorThemeMode.dark.shouldDark, true);

    t.binding.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    expect(ColorThemeMode.system.shouldDark, true);
    expect(ColorThemeMode.light.shouldDark, false);
    expect(ColorThemeMode.dark.shouldDark, true);

    t.binding.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    expect(ColorThemeMode.system.shouldDark, false);
    expect(ColorThemeMode.light.shouldDark, false);
    expect(ColorThemeMode.dark.shouldDark, true);
  });

  testWidgets('adaptive color theme', (t) async {
    final probe = Builder(
      builder: (context) {
        return context.find<ColorTheme>()!.brightness.name.asText().center();
      },
    );
    t.binding.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    final widget = probe.adaptiveColorTheme(ColorTheme.adapter());
    await t.pumpWidget(widget.ensureText());
    expect(find.text(Brightness.light.name), findsOneWidget);

    t.binding.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    await t.pump();
    expect(find.text(Brightness.dark.name), findsOneWidget);

    t.binding.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    await t.pump();
    expect(find.text(Brightness.light.name), findsOneWidget);
  });
}

class ColorTheme extends ColorThemeBase {
  const ColorTheme.light({
    super.background = Colors.snow,
    super.foreground = Colors.ink,
  }) : super.light();

  const ColorTheme.dark({
    super.background = Colors.coal,
    super.foreground = Colors.lunar,
  }) : super.dark();

  static ColorThemeAdapter<ColorTheme> adapter({
    ColorThemeMode mode = ColorThemeMode.system,
  }) =>
      ColorThemeAdapter(
        light: const ColorTheme.light(),
        dark: const ColorTheme.dark(),
        mode: mode,
      );
}
