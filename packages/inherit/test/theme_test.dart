import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inherit/inherit.dart';
import 'package:wrap/debug.dart';
import 'package:wrap/wrap.dart';

void main() {
  testWidgets('adapt theme mode', (t) async {
    t.binding.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    expect(ThemeMode.system.shouldDark, false);
    expect(ThemeMode.light.shouldDark, false);
    expect(ThemeMode.dark.shouldDark, true);

    t.binding.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    expect(ThemeMode.system.shouldDark, true);
    expect(ThemeMode.light.shouldDark, false);
    expect(ThemeMode.dark.shouldDark, true);

    t.binding.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    expect(ThemeMode.system.shouldDark, false);
    expect(ThemeMode.light.shouldDark, false);
    expect(ThemeMode.dark.shouldDark, true);
  });

  testWidgets('adaptive theme', (t) async {
    final probe = Builder(
      builder: (context) {
        return context.find<Theme>()!.brightness.name.asText().center();
      },
    );
    t.binding.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    final widget = probe.adaptiveTheme(Theme.adapter());
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

class Theme extends ThemeBase {
  const Theme.light({
    super.background = const Color(0xfffefdfa),
    super.foreground = const Color(0xff232426),
  }) : super.light();

  const Theme.dark({
    super.background = const Color(0xff18191a),
    super.foreground = const Color(0xffdedede),
  }) : super.dark();

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
