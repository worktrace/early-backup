// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: PartAnnotationsBuilder
// **************************************************************************

part of 'size.dart';

BorderSize _$lerp$BorderSize(BorderSize a, BorderSize b, double t) {
  return BorderSize(
    width: lerpDouble(a.width, b.width, t),
    radius: lerpBorderRadius(a.radius, b.radius, t),
  );
}

BoxShadowSize _$lerp$BoxShadowSize(BoxShadowSize a, BoxShadowSize b, double t) {
  return BoxShadowSize(
    offset: lerpOffset(a.offset, b.offset, t),
    blurRadius: lerpDouble(a.blurRadius, b.blurRadius, t),
    blurSpread: lerpDouble(a.blurSpread, b.blurSpread, t),
  );
}

CardSize _$lerp$CardSize(CardSize a, CardSize b, double t) {
  return CardSize(
    strokeAlign: lerpDouble(a.strokeAlign, b.strokeAlign, t),
    border: BorderSize.lerp(a.border, b.border, t),
    shadow: BoxShadowSize.lerp(a.shadow, b.shadow, t),
  );
}
