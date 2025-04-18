// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: PartDataBuilder
// **************************************************************************

part of 'ripple_area.dart';

mixin _$Copy$RippleCardColors implements Copyable {
  RippleCardColors get _template => this as RippleCardColors;

  @override
  RippleCardColors copyWith({
    Color? foreground,
    Color? background,
    Color? border,
    Color? shadow,
    AreaColors? ripple,
  }) {
    return RippleCardColors(
      foreground: foreground ?? _template.foreground,
      background: background ?? _template.background,
      border: border ?? _template.border,
      shadow: shadow ?? _template.shadow,
      ripple: ripple ?? _template.ripple,
    );
  }
}

RippleCardColors _$lerp$RippleCardColors(
  RippleCardColors a,
  RippleCardColors b,
  double t,
) {
  return RippleCardColors(
    foreground: Color.lerp(a.foreground, b.foreground, t),
    background: lerpColor(a.background, b.background, t),
    border: lerpColor(a.border, b.border, t),
    shadow: lerpColor(a.shadow, b.shadow, t),
    ripple: AreaColors.lerp(a.ripple, b.ripple, t),
  );
}
