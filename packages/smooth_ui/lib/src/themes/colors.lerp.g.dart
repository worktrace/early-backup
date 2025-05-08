// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: PartAnnotationsBuilder
// **************************************************************************

part of 'colors.dart';

AreaColors _$lerp$AreaColors(AreaColors a, AreaColors b, double t) {
  return AreaColors(
    background: lerpColor(a.background, b.background, t),
    foreground: Color.lerp(a.foreground, b.foreground, t),
  );
}

CardColors _$lerp$CardColors(CardColors a, CardColors b, double t) {
  return CardColors(
    border: lerpColor(a.border, b.border, t),
    shadow: lerpColor(a.shadow, b.shadow, t),
  );
}
