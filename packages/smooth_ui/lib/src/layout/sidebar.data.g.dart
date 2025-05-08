// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: PartAnnotationsBuilder
// **************************************************************************

part of 'sidebar.dart';

extension CopySidebarColors on SidebarColors {
  SidebarColors copyWith({
    Color? background,
    Color? foreground,
    Color? border,
    Color? shadow,
    AreaColors? ripple,
    Color? resize,
  }) {
    return SidebarColors(
      background: background ?? this.background,
      foreground: foreground ?? this.foreground,
      border: border ?? this.border,
      shadow: shadow ?? this.shadow,
      ripple: ripple ?? this.ripple,
      resize: resize ?? this.resize,
    );
  }
}

extension CopySidebarSize on SidebarSize {
  SidebarSize copyWith({
    EdgeInsetsDirectional? padding,
    double? strokeAlign,
    BorderSize? border,
    BoxShadowSize? shadow,
    double? sidebarMinWidth,
    double? contentMinWidth,
    double? resizeWidth,
    EdgeInsetsDirectional? resizePadding,
  }) {
    return SidebarSize(
      padding: padding ?? this.padding,
      strokeAlign: strokeAlign ?? this.strokeAlign,
      border: border ?? this.border,
      shadow: shadow ?? this.shadow,
      sidebarMinWidth: sidebarMinWidth ?? this.sidebarMinWidth,
      contentMinWidth: contentMinWidth ?? this.contentMinWidth,
      resizeWidth: resizeWidth ?? this.resizeWidth,
      resizePadding: resizePadding ?? this.resizePadding,
    );
  }
}
