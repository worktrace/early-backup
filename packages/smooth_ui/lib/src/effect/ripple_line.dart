import 'dart:math';

import 'package:build_data/annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:state_reuse/animation.dart';
import 'package:wrap/wrap.dart';

import 'ripple.dart';

part 'ripple_line.data.g.dart';

extension WrapRippleLine on Widget? {
  RippleLine rippleLine({
    Key? key,
    AnimationDefibrillation animation = kRippleAnimation,
    Color color = kRippleColor,
    bool hold = false,
    PointerEnterEventListener? onEnter,
    PointerExitEventListener? onExit,
    PointerHoverEventListener? onHover,
    MouseCursor cursor = MouseCursor.defer,
    HitTestBehavior hitTestBehavior = HitTestBehavior.opaque,
    bool opaque = true,
    EdgeInsets padding = EdgeInsets.zero,
  }) => RippleLine(
    key: key,
    animation: animation,
    color: color,
    hold: hold,
    onEnter: onEnter,
    onExit: onExit,
    onHover: onHover,
    cursor: cursor,
    hitTestBehavior: hitTestBehavior,
    opaque: opaque,
    padding: padding,
    child: this,
  );
}

class RippleLine extends RippleBase {
  const RippleLine({
    super.key,
    super.animation,
    this.color = kRippleColor,
    super.hold,
    super.onEnter,
    super.onExit,
    super.onHover,
    super.cursor,
    super.hitTestBehavior = HitTestBehavior.opaque,
    super.opaque = true,
    this.padding = EdgeInsets.zero,
    super.child,
  });

  final Color color;
  final EdgeInsets padding;

  @override
  State<RippleLine> createState() => _RippleHoverLineState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DiagnosticsProperty<EdgeInsets>('padding', padding));
  }
}

class _RippleHoverLineState extends RippleBaseState<RippleLine> {
  @override
  CustomPainter get painter => RippleLinePainter(
    color: widget.color,
    center: center,
    ratio: controller.value,
    padding: widget.padding,
  );
}

@equals
class RippleLinePainter extends RipplePainter {
  const RippleLinePainter({
    required super.color,
    super.center,
    super.ratio,
    this.padding = EdgeInsets.zero,
  });

  final EdgeInsets padding;

  @override
  void paint(Canvas canvas, Size size) {
    if (ratio == 0) return;
    canvas.drawRRect(
      lineAreaOf(size, padding, center, ratio).capsule,
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(covariant RippleLinePainter oldDelegate) {
    return _$equals$RippleLinePainter(this, oldDelegate);
  }
}

Rect lineAreaOf(Size size, EdgeInsets padding, Offset center, double ratio) {
  return size.width > size.height
      ? _hArea(size, padding, center, ratio)
      : _vArea(size, padding, center, ratio);
}

Rect _hArea(Size size, EdgeInsets padding, Offset center, double ratio) {
  final c = center.dx;
  final radius = size.width * ratio;
  return Rect.fromLTRB(
    max(c - radius, padding.left),
    padding.top,
    min(c + radius, size.width - padding.right),
    size.height - padding.bottom,
  );
}

Rect _vArea(Size size, EdgeInsets padding, Offset center, double ratio) {
  final c = center.dy;
  final radius = size.height * ratio;
  return Rect.fromLTRB(
    padding.left,
    max(c - radius, padding.top),
    size.width - padding.right,
    min(c + radius, size.height - padding.bottom),
  );
}
