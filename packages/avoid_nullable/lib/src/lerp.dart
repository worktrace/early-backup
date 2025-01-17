import 'package:flutter/widgets.dart';

/// Similar to [Tween], but not nullable, and conciser.
class AnimationTween<T> {
  const AnimationTween({required this.begin, required this.end});

  final T begin;
  final T end;

  T of(AnimationController controller, Lerp<T> lerp) {
    return lerp(begin, end, controller.value);
  }
}

/// The type declaration of a lerp function for code reuse.
typedef Lerp<T> = T Function(T begin, T end, double t);

/// Optimization over the raw nullable lerp functions:
/// There's no null check, which is more efficient.
double lerpDouble(double a, double b, double t) => a + (b - a) * t;

/// Optimization over the raw nullable lerp functions:
/// There's no null check, which is more efficient.
int lerpInt(int a, int b, double t) => a + ((b - a) * t).round();

/// Optimization over the raw nullable lerp functions:
/// There's no null check, which is more efficient.
Color lerpColor(Color a, Color b, double t) {
  return Color.from(
    alpha: lerpDouble(a.a, b.b, t),
    red: lerpDouble(a.r, b.r, t),
    green: lerpDouble(a.g, b.g, t),
    blue: lerpDouble(a.b, b.b, t),
  );
}

Radius lerpRadius(Radius a, Radius b, double t) {
  return Radius.elliptical(lerpDouble(a.x, b.x, t), lerpDouble(a.y, b.y, t));
}

BorderRadius lerpBorderRadius(BorderRadius a, BorderRadius b, double t) {
  return BorderRadius.only(
    topLeft: lerpRadius(a.topLeft, b.topLeft, t),
    topRight: lerpRadius(a.topRight, b.topRight, t),
    bottomLeft: lerpRadius(a.bottomLeft, b.bottomLeft, t),
    bottomRight: lerpRadius(a.bottomRight, b.bottomRight, t),
  );
}
