import 'package:auto_stories/src/utils.dart';
import 'package:flutter/foundation.dart';

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
