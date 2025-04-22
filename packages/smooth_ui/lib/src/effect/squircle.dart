import 'package:build_data/annotation.dart';
import 'package:compat_utils/number.dart';
import 'package:flutter/widgets.dart';
import 'package:wrap/convert.dart';
import 'package:wrap/wrap.dart';

extension WrapSquircle on Widget {
  ClipPath clipSquircle({
    Key? key,
    required BorderRadius radius,
    Clip clipBehavior = Clip.antiAlias,
  }) => clipPath(
    key: key,
    clipper: SquircleClipper(radius: radius),
    clipBehavior: clipBehavior,
  );

  Widget squircle({
    Key? key,
    required BorderSide border,
    required BorderRadius radius,
    Color? color,
    DecorationImage? image,
    Gradient? gradient,
    List<BoxShadow>? shadows,
    DecorationPosition position = DecorationPosition.background,
    Clip clipBehavior = Clip.antiAlias,
  }) {
    final shape = SquircleBorder(border: border, radius: radius);
    final clipped = clipSquircle(radius: radius, clipBehavior: clipBehavior);
    if (border == BorderSide.none) return clipped;
    return clipped.decorate(
      key: key,
      position: position,
      decoration: ShapeDecoration(
        shape: shape,
        color: color,
        image: image,
        gradient: gradient,
        shadows: shadows,
      ),
    );
  }
}

class SquircleBorder extends OutlinedBorder {
  const SquircleBorder({required this.border, required this.radius});

  factory SquircleBorder.lerp(SquircleBorder a, SquircleBorder b, double t) {
    return SquircleBorder(
      border: BorderSide.lerp(a.border, b.border, t),
      radius: lerpBorderRadius(a.radius, b.radius, t),
    );
  }

  final BorderSide border;
  final BorderRadius radius;

  @override
  SquircleBorder copyWith({BorderSide? side, BorderRadius? radius}) {
    return SquircleBorder(
      border: side ?? border,
      radius: radius ?? this.radius,
    );
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return drawSquircle(rect.deflate(border.strokeInset), radius);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return drawSquircle(rect.inflate(border.strokeOutset), radius);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (border.style == BorderStyle.none) return;
    final path = drawSquircle(rect.inflate(border.strokeAlign), radius);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = border.color
      ..strokeWidth = border.width;
    canvas.drawPath(path, paint);
  }

  @override
  SquircleBorder scale(double t) {
    return SquircleBorder(border: border.scale(t), radius: radius * t);
  }
}

class SquircleClipper extends CustomClipper<Path> {
  const SquircleClipper({this.radius = BorderRadius.zero});

  final BorderRadius radius;

  @override
  Path getClip(Size size) => drawSquircle(size.toRectFill, radius);

  @override
  bool shouldReclip(covariant SquircleClipper oldClipper) {
    return radius != oldClipper.radius;
  }
}

/// Computed value of sqrt^4(1/2).
const squircleRatio = 0.8408964152537146;

/// Computed value of 1 - sqrt^4(1/2).
const squircleRatioComplement = 0.1591035847462854;

const double squircleArmRatio = goldenRatio;

extension SquircleRadius on Radius {
  double get squircleCornerX => x * squircleRatioComplement;
  double get squircleArmpitX => isSquare
      ? squircleCornerX + squircleCornerX
      : squircleCornerX * (1 + ratioInverse.square);

  double get squircleCornerY => y * squircleRatioComplement;
  double get squircleArmpitY => isSquare
      ? squircleCornerY + squircleCornerY
      : squircleCornerY * (1 + ratio.square);

  double get squircleArmX => x - (x - squircleArmpitX) * squircleArmRatio;
  double get squircleArmY => y - (y - squircleArmpitY) * squircleArmRatio;
}

/// Use bezel curves to mock a squircle.
///
/// This is a balance between effect and efficiency.
/// The principle is inspired by the following blogs,
/// and the key parameter is selected as the golden ratio.
///
/// see https://mathworld.wolfram.com/Squircle.html
/// see https://www.figma.com/blog/desperately-seeking-squircles/
Path drawSquircle(Rect rect, BorderRadius radius) {
  if (radius == BorderRadius.zero) {
    return Path()
      ..addRect(rect)
      ..close();
  }

  final top = rect.top;
  final left = rect.left;
  final right = rect.right;
  final bottom = rect.bottom;
  final path = Path()
    ..moveTo(left + radius.topLeft.x, top)
    ..lineTo(right - radius.topRight.x, top);

  if (radius.topRight != Radius.zero) {
    final corner = radius.topRight;
    path.cubicTo(
      right - corner.squircleArmX,
      top,
      right - corner.squircleArmpitX,
      top,
      right - corner.squircleCornerX,
      top + corner.squircleCornerY,
    );
    // ignore: cascade_invocations readable.
    path.cubicTo(
      right,
      top + corner.squircleArmpitY,
      right,
      top + corner.squircleArmY,
      right,
      top + corner.y,
    );
  }

  path.lineTo(rect.right, rect.bottom - radius.bottomRight.y);
  if (radius.bottomRight != Radius.zero) {
    final corner = radius.bottomRight;
    path.cubicTo(
      right,
      bottom - corner.squircleArmY,
      right,
      bottom - corner.squircleArmpitY,
      right - corner.squircleCornerX,
      bottom - corner.squircleCornerY,
    );
    // ignore: cascade_invocations readable.
    path.cubicTo(
      right - corner.squircleArmpitX,
      bottom,
      right - corner.squircleArmX,
      bottom,
      right - corner.x,
      bottom,
    );
  }

  path.lineTo(rect.left + radius.bottomLeft.x, rect.bottom);
  if (radius.bottomLeft != Radius.zero) {
    final corner = radius.bottomLeft;
    path.cubicTo(
      left + corner.squircleArmX,
      bottom,
      left + corner.squircleArmpitX,
      bottom,
      left + corner.squircleCornerX,
      bottom - corner.squircleCornerY,
    );
    // ignore: cascade_invocations readable.
    path.cubicTo(
      left,
      bottom - corner.squircleArmpitY,
      left,
      bottom - corner.squircleArmY,
      left,
      bottom - corner.y,
    );
  }

  path.lineTo(rect.left, rect.top + radius.topLeft.y);
  if (radius.topLeft != Radius.zero) {
    final corner = radius.topLeft;
    path.cubicTo(
      left,
      top + corner.squircleArmY,
      left,
      top + corner.squircleArmpitY,
      left + corner.squircleCornerX,
      top + corner.squircleCornerY,
    );
    // ignore: cascade_invocations readable.
    path.cubicTo(
      left + corner.squircleArmpitX,
      top,
      left + corner.squircleArmX,
      top,
      left + corner.x,
      top,
    );
  }

  return path..close();
}
