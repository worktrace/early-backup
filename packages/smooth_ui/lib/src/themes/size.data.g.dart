// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: PartDataBuilder
// **************************************************************************

part of 'size.dart';

mixin _$Copy$BorderSize implements Copyable {
  BorderSize get _template => this as BorderSize;

  @override
  BorderSize copyWith({double? width, BorderRadius? radius}) {
    return BorderSize(
      width: width ?? _template.width,
      radius: radius ?? _template.radius,
    );
  }
}

BorderSize _$lerp$BorderSize(BorderSize a, BorderSize b, double t) {
  return BorderSize(
    width: lerpDouble(a.width, b.width, t),
    radius: lerpBorderRadius(a.radius, b.radius, t),
  );
}

mixin _$Copy$BoxShadowSize implements Copyable {
  BoxShadowSize get _template => this as BoxShadowSize;

  @override
  BoxShadowSize copyWith({
    Offset? offset,
    double? blurRadius,
    double? blurSpread,
  }) {
    return BoxShadowSize(
      offset: offset ?? _template.offset,
      blurRadius: blurRadius ?? _template.blurRadius,
      blurSpread: blurSpread ?? _template.blurSpread,
    );
  }
}

BoxShadowSize _$lerp$BoxShadowSize(BoxShadowSize a, BoxShadowSize b, double t) {
  return BoxShadowSize(
    offset: lerpOffset(a.offset, b.offset, t),
    blurRadius: lerpDouble(a.blurRadius, b.blurRadius, t),
    blurSpread: lerpDouble(a.blurSpread, b.blurSpread, t),
  );
}

mixin _$Copy$CardSize implements Copyable {
  CardSize get _template => this as CardSize;

  @override
  CardSize copyWith({
    double? strokeAlign,
    BorderSize? border,
    BoxShadowSize? shadow,
  }) {
    return CardSize(
      strokeAlign: strokeAlign ?? _template.strokeAlign,
      border: border ?? _template.border,
      shadow: shadow ?? _template.shadow,
    );
  }
}

CardSize _$lerp$CardSize(CardSize a, CardSize b, double t) {
  return CardSize(
    strokeAlign: lerpDouble(a.strokeAlign, b.strokeAlign, t),
    border: BorderSize.lerp(a.border, b.border, t),
    shadow: BoxShadowSize.lerp(a.shadow, b.shadow, t),
  );
}
