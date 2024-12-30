import 'package:auto_stories/src/utils.dart';
import 'package:flutter/widgets.dart';

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
