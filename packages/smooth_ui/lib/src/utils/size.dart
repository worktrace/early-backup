import 'dart:math' as math;

import 'package:avoid_nullable/avoid_nullable.dart';
import 'package:compat_utils/compat_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:wrap/wrap.dart';

extension SizeUtils on Size {
  Rect get toRectFill => Rect.fromLTWH(0, 0, width, height);
  Rect toRect(Offset offset) {
    return Rect.fromLTWH(offset.dx, offset.dy, width, height);
  }

  /// Equals width + height.
  /// A value longer than diagonal and easy to compute.
  /// This value is designed to simplify computation to improve performance.
  double get longerThanDiagonal => width + height;
  double get diagonal => math.sqrt(width.square + height.square);
}

extension RadiusConvert on Radius {
  /// Whether x == y.
  bool get isSquare => x == y;

  /// Equals x / y.
  double get ratio => x / y;

  /// Equals y / x.
  double get ratioInverse => y / x;
}

class BorderSize {
  const BorderSize({this.width = 1, this.radius = BorderRadius.zero});

  factory BorderSize.lerp(BorderSize a, BorderSize b, double t) {
    return BorderSize(
      width: lerpDouble(a.width, b.width, t),
      radius: lerpBorderRadius(a.radius, b.radius, t),
    );
  }

  static const zero = BorderSize(width: 0);

  final double width;
  final BorderRadius radius;
}

class BoxShadowSize {
  const BoxShadowSize({
    this.offset = Offset.zero,
    this.blurRadius = 0,
    this.blurSpread = 0,
  });

  factory BoxShadowSize.lerp(BoxShadowSize a, BoxShadowSize b, double t) {
    return BoxShadowSize(
      offset: lerpOffset(a.offset, b.offset, t),
      blurRadius: lerpDouble(a.blurRadius, b.blurRadius, t),
      blurSpread: lerpDouble(a.blurSpread, b.blurSpread, t),
    );
  }

  static const zero = BoxShadowSize();

  final Offset offset;
  final double blurRadius;
  final double blurSpread;

  bool get hasShadow {
    return offset != Offset.zero || blurRadius > 0 || blurSpread > 0;
  }

  BoxShadow? maybeToShadow(
    Color color, {
    BlurStyle blurStyle = BlurStyle.normal,
  }) {
    return color != transparent && hasShadow
        ? toShadow(color, blurStyle: blurStyle)
        : null;
  }

  BoxShadow toShadow(Color color, {BlurStyle blurStyle = BlurStyle.normal}) {
    return BoxShadow(
      color: color,
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: blurSpread,
      blurStyle: blurStyle,
    );
  }
}
