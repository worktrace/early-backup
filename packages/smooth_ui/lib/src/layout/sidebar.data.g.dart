// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: PartDataBuilder
// **************************************************************************

part of 'sidebar.dart';

mixin _$Copy$SidebarColors implements Copyable {
  SidebarColors get _template => this as SidebarColors;

  @override
  SidebarColors copyWith({
    Color? background,
    Color? foreground,
    Color? border,
    Color? shadow,
    AreaColors? ripple,
    Color? resize,
  }) => SidebarColors(
    background: background ?? _template.background,
    foreground: foreground ?? _template.foreground,
    border: border ?? _template.border,
    shadow: shadow ?? _template.shadow,
    ripple: ripple ?? _template.ripple,
    resize: resize ?? _template.resize,
  );
}

SidebarColors _$lerp$SidebarColors(
  SidebarColors a,
  SidebarColors b,
  double t,
) => SidebarColors(
  background: lerpColor(a.background, b.background, t),
  foreground: Color.lerp(a.foreground, b.foreground, t),
  border: lerpColor(a.border, b.border, t),
  shadow: lerpColor(a.shadow, b.shadow, t),
  ripple: AreaColors.lerp(a.ripple, b.ripple, t),
  resize: lerpColor(a.resize, b.resize, t),
);

mixin _$Copy$SidebarSize implements Copyable {
  SidebarSize get _template => this as SidebarSize;

  @override
  SidebarSize copyWith({
    EdgeInsetsDirectional? padding,
    double? strokeAlign,
    BorderSize? border,
    BoxShadowSize? shadow,
    double? sidebarMinWidth,
    double? contentMinWidth,
    double? resizeWidth,
    EdgeInsetsDirectional? resizePadding,
  }) => SidebarSize(
    padding: padding ?? _template.padding,
    strokeAlign: strokeAlign ?? _template.strokeAlign,
    border: border ?? _template.border,
    shadow: shadow ?? _template.shadow,
    sidebarMinWidth: sidebarMinWidth ?? _template.sidebarMinWidth,
    contentMinWidth: contentMinWidth ?? _template.contentMinWidth,
    resizeWidth: resizeWidth ?? _template.resizeWidth,
    resizePadding: resizePadding ?? _template.resizePadding,
  );
}

SidebarSize _$lerp$SidebarSize(SidebarSize a, SidebarSize b, double t) =>
    SidebarSize(
      padding: lerpEdgeInsetsDirectional(a.padding, b.padding, t),
      strokeAlign: lerpDouble(a.strokeAlign, b.strokeAlign, t),
      border: BorderSize.lerp(a.border, b.border, t),
      shadow: BoxShadowSize.lerp(a.shadow, b.shadow, t),
      sidebarMinWidth: lerpDouble(a.sidebarMinWidth, b.sidebarMinWidth, t),
      contentMinWidth: lerpDouble(a.contentMinWidth, b.contentMinWidth, t),
      resizeWidth: lerpDouble(a.resizeWidth, b.resizeWidth, t),
      resizePadding: lerpEdgeInsetsDirectional(
        a.resizePadding,
        b.resizePadding,
        t,
      ),
    );
