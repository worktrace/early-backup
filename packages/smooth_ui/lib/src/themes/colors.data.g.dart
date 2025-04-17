// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: PartDataBuilder
// **************************************************************************

part of 'colors.dart';

mixin _$Copy$AreaColors implements Copyable {
  AreaColors get _template => this as AreaColors;

  @override
  AreaColors copyWith({Color? background, Color? foreground}) => AreaColors(
    background: background ?? _template.background,
    foreground: foreground ?? _template.foreground,
  );
}

AreaColors _$lerp$AreaColors(AreaColors a, AreaColors b, double t) =>
    AreaColors(
      background: lerpColor(a.background, b.background, t),
      foreground: Color.lerp(a.foreground, b.foreground, t),
    );

mixin _$Copy$CardColors implements Copyable {
  CardColors get _template => this as CardColors;

  @override
  CardColors copyWith({
    Color? background,
    Color? foreground,
    Color? border,
    Color? shadow,
  }) => CardColors(
    background: background ?? _template.background,
    foreground: foreground ?? _template.foreground,
    border: border ?? _template.border,
    shadow: shadow ?? _template.shadow,
  );
}

CardColors _$lerp$CardColors(CardColors a, CardColors b, double t) =>
    CardColors(
      background: lerpColor(a.background, b.background, t),
      foreground: Color.lerp(a.foreground, b.foreground, t),
      border: lerpColor(a.border, b.border, t),
      shadow: lerpColor(a.shadow, b.shadow, t),
    );
