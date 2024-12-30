import 'package:flutter/widgets.dart';

class AnimationData {
  const AnimationData({
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  final Duration duration;
  final Curve curve;

  AnimationData copyWith({Duration? duration, Curve? curve}) {
    return AnimationData(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
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
