import 'package:avoid_nullable/avoid_nullable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_ui/utils.dart';
import 'package:state_reuse/animation.dart';
import 'package:wrap/utils.dart';
import 'package:wrap/wrap.dart';

import 'ripple.dart';

extension WrapRippleArea on Widget? {
  RippleArea ripple({
    Key? key,
    AnimationDefibrillation animation = kRippleAnimation,
    AreaColors colors = kRippleAreaColors,
    bool hold = false,
    PointerEnterEventListener? onEnter,
    PointerExitEventListener? onExit,
    PointerHoverEventListener? onHover,
    bool opaque = true,
    HitTestBehavior hitTestBehavior = HitTestBehavior.opaque,
    BorderRadius radius = BorderRadius.zero,
  }) {
    return RippleArea(
      key: key,
      animation: animation,
      colors: colors,
      hold: hold,
      onEnter: onEnter,
      onExit: onExit,
      onHover: onHover,
      opaque: opaque,
      hitTestBehavior: hitTestBehavior,
      radius: radius,
      child: this,
    );
  }
}

const kRippleAreaColors = AreaColors(
  background: kRippleColor,
  foreground: white,
);

class RippleArea extends RippleBase {
  const RippleArea({
    super.key,
    super.animation,
    this.colors = kRippleAreaColors,
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

class RippleCardColors extends CardColors {
  const RippleCardColors({
    super.foreground,
    super.background,
    super.border,
    super.shadow,
    this.ripple = const AreaColors(background: kDimRippleColor),
  });

  factory RippleCardColors.lerp(
    RippleCardColors a,
    RippleCardColors b,
    double t,
  ) {
    return RippleCardColors(
      foreground: Color.lerp(a.foreground, b.foreground, t),
      background: lerpColor(a.background, b.background, t),
      border: lerpColor(a.border, b.border, t),
      shadow: lerpColor(a.shadow, b.shadow, t),
      ripple: AreaColors.lerp(a.ripple, b.ripple, t),
    );
  }

  final AreaColors ripple;
}
