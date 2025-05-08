// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: PartAnnotationsBuilder
// **************************************************************************

part of 'colors.dart';

extension CopyColors on Colors {
  Colors copyWith({
    Brightness? brightness,
    Color? foreground,
    Color? background,
    SidebarColors? sidebar,
  }) {
    return Colors.light(
      brightness: brightness ?? this.brightness,
      foreground: foreground ?? this.foreground,
      background: background ?? this.background,
      sidebar: sidebar ?? this.sidebar,
    );
  }
}
