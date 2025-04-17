// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: PartDataBuilder
// **************************************************************************

part of 'size.dart';

mixin _$Copy$BorderSize implements Copyable {
  BorderSize get _template => this as BorderSize;

  @override
  BorderSize copyWith({double? width, BorderRadius? radius}) => BorderSize(
    width: width ?? _template.width,
    radius: radius ?? _template.radius,
  );
}

mixin _$Copy$BoxShadowSize implements Copyable {
  BoxShadowSize get _template => this as BoxShadowSize;

  @override
  BoxShadowSize copyWith({
    Offset? offset,
    double? blurRadius,
    double? blurSpread,
  }) => BoxShadowSize(
    offset: offset ?? _template.offset,
    blurRadius: blurRadius ?? _template.blurRadius,
    blurSpread: blurSpread ?? _template.blurSpread,
  );
}

mixin _$Copy$CardSize implements Copyable {
  CardSize get _template => this as CardSize;

  @override
  CardSize copyWith({
    double? strokeAlign,
    BorderSize? border,
    BoxShadowSize? shadow,
  }) => CardSize(
    strokeAlign: strokeAlign ?? _template.strokeAlign,
    border: border ?? _template.border,
    shadow: shadow ?? _template.shadow,
  );
}
