// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: PartDataBuilder
// **************************************************************************

part of 'colors.dart';

mixin _$Copy$Colors implements Copyable {
  Colors get _template => this as Colors;

  @override
  Colors copyWith({
    Brightness? brightness,
    Color? foreground,
    Color? background,
    SidebarColors? sidebar,
  }) {
    return Colors.light(
      brightness: brightness ?? _template.brightness,
      foreground: foreground ?? _template.foreground,
      background: background ?? _template.background,
      sidebar: sidebar ?? _template.sidebar,
    );
  }
}

Colors _$lerp$Colors(Colors a, Colors b, double t) {
  return Colors.light(
    brightness: t < 0.5 ? a.brightness : b.brightness,
    foreground: Color.lerp(a.foreground, b.foreground, t),
    background: lerpColor(a.background, b.background, t),
    sidebar: SidebarColors.lerp(a.sidebar, b.sidebar, t),
  );
}
