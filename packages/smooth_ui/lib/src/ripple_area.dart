import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:wrap/wrap.dart';

import 'ripple.dart';
import 'utils.dart';

class RippleArea extends RippleBase {
  const RippleArea({
    super.key,
    super.animation,
    this.colors = const AreaColors(
      background: kRippleColor,
      foreground: white,
    ),
    super.hold,
    super.onEnter,
    super.onExit,
    super.onHover,
    super.opaque = true,
    super.hitTestBehavior = HitTestBehavior.opaque,
    this.radius = BorderRadius.zero,
    super.child,
  });

  final AreaColors colors;
  final BorderRadius radius;

  @override
  State<RippleArea> createState() => _RippleHoverState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AreaColors>('colors', colors))
      ..add(DiagnosticsProperty<BorderRadius>('radius', radius));
  }
}

class _RippleHoverState extends RippleBaseState<RippleArea> {
  @override
  CustomPainter get painter {
    return RippleAreaPainter(
      center: center,
      ratio: controller.value,
      color: widget.colors.background,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.colors.foreground == null) return super.build(context);
    final foreground = DefaultTextStyle.of(context).style.color;
    final current = Color.lerp(
      foreground,
      widget.colors.foreground,
      controller.value,
    );

    return super.build(context).maybeForegroundAs(context, current);
  }
}

class RippleAreaPainter extends RipplePainter {
  const RippleAreaPainter({super.center, super.ratio, required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (ratio == 0) return;
    final radius = size.longerThanDiagonal * ratio;
    final paint = Paint()..color = color;
    canvas
      ..clipRect(size.toRectFill)
      ..drawCircle(center, radius, paint);
  }
}
