import 'package:build_data/annotation.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_ui/colors.dart';

part 'colors.data.g.dart';

class AreaColors with _$Copy$AreaColors implements Copyable {
  @copy
  @lerp
  const AreaColors({this.background = transparent, this.foreground});

  factory AreaColors.background(Color color) => AreaColors(background: color);
  factory AreaColors.foreground(Color color) => AreaColors(foreground: color);

  factory AreaColors.lerp(AreaColors a, AreaColors b, double t) {
    return _$lerp$AreaColors(a, b, t);
  }

  final Color background;
  final Color? foreground;
}

class CardColors extends AreaColors with _$Copy$CardColors {
  @copy
  @lerp
  const CardColors({
    super.background,
    super.foreground,
    this.border = transparent,
    this.shadow = transparent,
  });

  factory CardColors.lerp(CardColors a, CardColors b, double t) {
    return _$lerp$CardColors(a, b, t);
  }

  final Color border;
  final Color shadow;

  bool get hasShadow => shadow != transparent;
}
