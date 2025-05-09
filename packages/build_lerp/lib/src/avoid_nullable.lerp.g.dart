// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: PartAnnotationsBuilder
// **************************************************************************

part of 'avoid_nullable.dart';

@buildInLerp
Offset lerpOffset(Offset a, Offset b, double t) {
  return Offset(lerpDouble(a.dx, b.dx, t), lerpDouble(a.dy, b.dy, t));
}

@buildInLerp
Radius lerpRadius(Radius a, Radius b, double t) {
  return Radius.elliptical(lerpDouble(a.x, b.x, t), lerpDouble(a.y, b.y, t));
}

@buildInLerp
BorderRadius lerpBorderRadius(BorderRadius a, BorderRadius b, double t) {
  return BorderRadius.only(
    topLeft: lerpRadius(a.topLeft, b.topLeft, t),
    topRight: lerpRadius(a.topRight, b.topRight, t),
    bottomLeft: lerpRadius(a.bottomLeft, b.bottomLeft, t),
    bottomRight: lerpRadius(a.bottomRight, b.bottomRight, t),
  );
}

@buildInLerp
EdgeInsets lerpEdgeInsets(EdgeInsets a, EdgeInsets b, double t) {
  return EdgeInsets.only(
    left: lerpDouble(a.left, b.left, t),
    top: lerpDouble(a.top, b.top, t),
    right: lerpDouble(a.right, b.right, t),
    bottom: lerpDouble(a.bottom, b.bottom, t),
  );
}

@buildInLerp
EdgeInsetsDirectional lerpEdgeInsetsDirectional(
  EdgeInsetsDirectional a,
  EdgeInsetsDirectional b,
  double t,
) {
  return EdgeInsetsDirectional.only(
    start: lerpDouble(a.start, b.start, t),
    top: lerpDouble(a.top, b.top, t),
    end: lerpDouble(a.end, b.end, t),
    bottom: lerpDouble(a.bottom, b.bottom, t),
  );
}
