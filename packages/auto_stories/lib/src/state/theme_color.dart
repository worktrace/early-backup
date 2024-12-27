import 'package:auto_stories/src/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'binding.dart';

extension WrapColorTheme on Widget {
  Widget colorThemeAs<T extends ColorThemeBase>(BuildContext context, T theme) {
    return inherit(theme)
        .inherit(theme.brightness)
        .background(theme.background)
        .maybeForegroundAs(context, theme.foreground);
  }

  ColorThemeApply<T> colorTheme<T extends ColorThemeBase>(T theme, {Key? key}) {
    return ColorThemeApply(
      key: key,
      theme: theme,
      child: this,
    );
  }
}

enum ColorThemeMode {
  system,
  light,
  dark;

  bool get shouldDark {
    final mode = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return this == ColorThemeMode.system
        ? mode == Brightness.dark
        : this == ColorThemeMode.dark;
  }
}

class ColorThemeApply<T extends ColorThemeBase> extends StatelessWidget {
  const ColorThemeApply({super.key, required this.theme, required this.child});

  final T theme;
  final Widget child;

  @override
  Widget build(BuildContext context) => child.colorThemeAs(context, theme);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<T>('theme', theme));
  }
}

abstract class ColorThemeBase extends AreaColors {
  const ColorThemeBase.light({
    required super.foreground,
    required super.background,
    this.brightness = Brightness.light,
  });

  const ColorThemeBase.dark({
    required super.foreground,
    required super.background,
    this.brightness = Brightness.dark,
  });

  final Brightness brightness;
}
