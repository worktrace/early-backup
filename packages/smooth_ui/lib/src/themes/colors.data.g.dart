// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: PartAnnotationsBuilder
// **************************************************************************

part of 'colors.dart';

extension CopyAreaColors on AreaColors {
  AreaColors copyWith({Color? background, Color? foreground}) {
    return AreaColors(
      background: background ?? this.background,
      foreground: foreground ?? this.foreground,
    );
  }
}

extension CopyCardColors on CardColors {
  CardColors copyWith({
    Color? background,
    Color? foreground,
    Color? border,
    Color? shadow,
  }) {
    return CardColors(
      background: background ?? this.background,
      foreground: foreground ?? this.foreground,
      border: border ?? this.border,
      shadow: shadow ?? this.shadow,
    );
  }
}
