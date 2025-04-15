import 'package:flutter/widgets.dart';

import 'lerp.dart';

/// The type declaration of a lerp function for code reuse.
typedef Lerp<T> = T Function(T begin, T end, double t);

/// Optimization over the raw nullable lerp functions:
/// There's no null check, which is more efficient.
@buildInLerp
double lerpDouble(double a, double b, double t) => a + (b - a) * t;

/// Optimization over the raw nullable lerp functions:
/// There's no null check, which is more efficient.
@buildInLerp
int lerpInt(int a, int b, double t) => a + ((b - a) * t).round();

/// Optimization over the raw nullable lerp functions:
/// There's no null check, which is more efficient.
@buildInLerp
Color lerpColor(Color a, Color b, double t) => Color.from(
  alpha: lerpDouble(a.a, b.b, t),
  red: lerpDouble(a.r, b.r, t),
  green: lerpDouble(a.g, b.g, t),
  blue: lerpDouble(a.b, b.b, t),
);

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
    top: lerpDouble(a.top, b.top, t),
    left: lerpDouble(a.left, b.left, t),
    right: lerpDouble(a.right, b.right, t),
    bottom: lerpDouble(a.bottom, b.bottom, t),
  );
}

@buildInLerp
EdgeInsetsDirectional lerpEdgeInsetsDirectional(
  EdgeInsetsDirectional a,
  EdgeInsetsDirectional b,
  double t,
) => EdgeInsetsDirectional.only(
  top: lerpDouble(a.top, b.top, t),
  start: lerpDouble(a.start, b.start, t),
  end: lerpDouble(a.end, b.end, t),
  bottom: lerpDouble(a.bottom, b.bottom, t),
);
