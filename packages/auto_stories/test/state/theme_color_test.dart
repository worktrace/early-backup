import 'package:auto_stories/auto_stories.dart';
import 'package:flutter/foundation.dart';
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
}
