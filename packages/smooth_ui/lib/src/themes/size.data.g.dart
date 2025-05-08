// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: PartAnnotationsBuilder
// **************************************************************************

part of 'size.dart';

extension CopyBorderSize on BorderSize {
  BorderSize copyWith({double? width, BorderRadius? radius}) {
    return BorderSize(
      width: width ?? this.width,
      radius: radius ?? this.radius,
    );
  }
}

extension CopyBoxShadowSize on BoxShadowSize {
  BoxShadowSize copyWith({
    Offset? offset,
    double? blurRadius,
    double? blurSpread,
  }) {
    return BoxShadowSize(
      offset: offset ?? this.offset,
      blurRadius: blurRadius ?? this.blurRadius,
      blurSpread: blurSpread ?? this.blurSpread,
    );
  }
}

extension CopyCardSize on CardSize {
  CardSize copyWith({
    double? strokeAlign,
    BorderSize? border,
    BoxShadowSize? shadow,
  }) {
    return CardSize(
      strokeAlign: strokeAlign ?? this.strokeAlign,
      border: border ?? this.border,
      shadow: shadow ?? this.shadow,
    );
  }
}
