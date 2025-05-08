// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: PartAnnotationsBuilder
// **************************************************************************

part of 'sidebar.dart';

SidebarColors _$lerp$SidebarColors(SidebarColors a, SidebarColors b, double t) {
  return SidebarColors(resize: lerpColor(a.resize, b.resize, t));
}

SidebarSize _$lerp$SidebarSize(SidebarSize a, SidebarSize b, double t) {
  return SidebarSize(
    padding: lerpEdgeInsetsDirectional(a.padding, b.padding, t),
    sidebarMinWidth: lerpDouble(a.sidebarMinWidth, b.sidebarMinWidth, t),
    contentMinWidth: lerpDouble(a.contentMinWidth, b.contentMinWidth, t),
    resizeWidth: lerpDouble(a.resizeWidth, b.resizeWidth, t),
    resizePadding: lerpEdgeInsetsDirectional(
      a.resizePadding,
      b.resizePadding,
      t,
    ),
  );
}
