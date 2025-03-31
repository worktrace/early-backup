import 'package:flutter/widgets.dart';
import 'package:state_reuse/animation.dart';
import 'package:wrap/utils.dart';

class AreaColors {
  const AreaColors({this.background = transparent, this.foreground});

  factory AreaColors.background(Color color) => AreaColors(background: color);
  factory AreaColors.foreground(Color color) => AreaColors(foreground: color);

  factory AreaColors.lerp(AreaColors a, AreaColors b, double t) {
    return AreaColors(
      background: lerpColor(a.background, b.background, t),
      foreground: Color.lerp(a.foreground, b.foreground, t),
    );
  }

  final Color background;
  final Color? foreground;
}

class CardColors extends AreaColors {
  const CardColors({
    super.background,
    super.foreground,
    this.border = transparent,
    this.shadow = transparent,
  });

  factory CardColors.lerp(CardColors a, CardColors b, double t) {
    return CardColors(
      background: lerpColor(a.background, b.background, t),
      foreground: Color.lerp(a.foreground, b.foreground, t),
      border: lerpColor(a.border, b.border, t),
      shadow: lerpColor(a.shadow, b.shadow, t),
    );
  }

  final Color border;
  final Color shadow;

  bool get hasShadow => shadow != transparent;
}
