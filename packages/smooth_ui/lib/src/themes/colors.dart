import 'package:data_build/annotation.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_ui/colors.dart';
import 'package:state_reuse/animation.dart';

part 'colors.data.g.dart';

@lerp
class AreaColors with _$Copy$AreaColors implements Copyable {
  @copy
  const AreaColors({this.background = transparent, this.foreground});

  factory AreaColors.background(Color color) => AreaColors(background: color);
  factory AreaColors.foreground(Color color) => AreaColors(foreground: color);

  factory AreaColors.lerp(AreaColors a, AreaColors b, double t) => AreaColors(
    background: lerpColor(a.background, b.background, t),
    foreground: Color.lerp(a.foreground, b.foreground, t),
  );

  final Color background;
  final Color? foreground;
}

@lerp
class CardColors extends AreaColors with _$Copy$CardColors {
  @copy
  const CardColors({
    super.background,
    super.foreground,
    this.border = transparent,
    this.shadow = transparent,
  });

  factory CardColors.lerp(CardColors a, CardColors b, double t) => CardColors(
    background: lerpColor(a.background, b.background, t),
    foreground: Color.lerp(a.foreground, b.foreground, t),
    border: lerpColor(a.border, b.border, t),
    shadow: lerpColor(a.shadow, b.shadow, t),
  );

  final Color border;
  final Color shadow;

  bool get hasShadow => shadow != transparent;
}
