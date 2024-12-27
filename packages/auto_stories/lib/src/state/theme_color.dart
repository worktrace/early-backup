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
