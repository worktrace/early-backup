import 'package:build_data/annotation.dart';
import 'package:build_lerp/annotation.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_ui/colors.dart';

part 'size.data.g.dart';

class BorderSize with _$Copy$BorderSize {
  @copy
  @lerp
  const BorderSize({this.width = 1, this.radius = BorderRadius.zero});

  factory BorderSize.lerp(BorderSize a, BorderSize b, double t) {
    return _$lerp$BorderSize(a, b, t);
  }

  static const zero = BorderSize(width: 0);

  final double width;
  final BorderRadius radius;
}

class BoxShadowSize with _$Copy$BoxShadowSize {
  @copy
  @lerp
  const BoxShadowSize({
    this.offset = Offset.zero,
    this.blurRadius = 0,
    this.blurSpread = 0,
  });

  factory BoxShadowSize.lerp(BoxShadowSize a, BoxShadowSize b, double t) {
    return _$lerp$BoxShadowSize(a, b, t);
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

class CardSize with _$Copy$CardSize {
  @copy
  @lerp
  const CardSize({
    this.strokeAlign = BorderSide.strokeAlignOutside,
    this.border = BorderSize.zero,
    this.shadow = BoxShadowSize.zero,
  });

  factory CardSize.lerp(CardSize a, CardSize b, double t) {
    return _$lerp$CardSize(a, b, t);
  }

  final double strokeAlign;
  final BorderSize border;
  final BoxShadowSize shadow;
}
