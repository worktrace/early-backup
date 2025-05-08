import 'package:build_data/annotation.dart';
import 'package:build_lerp/annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_ui/_utils.dart';
import 'package:smooth_ui/themes.dart';
import 'package:state_reuse/animation.dart';
import 'package:wrap/wrap.dart';

import 'ripple.dart';

part 'ripple_area.data.g.dart';
part 'ripple_area.lerp.g.dart';

extension WrapRippleArea on Widget? {
  RippleArea ripple({
    Key? key,
    AnimationDefibrillation animation = kRippleAnimation,
    AreaColors colors = kRippleAreaColors,
    bool hold = false,
    PointerEnterEventListener? onEnter,
    PointerExitEventListener? onExit,
    PointerHoverEventListener? onHover,
    MouseCursor cursor = MouseCursor.defer,
    HitTestBehavior hitTestBehavior = HitTestBehavior.opaque,
    bool opaque = true,
    BorderRadius radius = BorderRadius.zero,
  }) => RippleArea(
    key: key,
    animation: animation,
    colors: colors,
    hold: hold,
    onEnter: onEnter,
    onExit: onExit,
    onHover: onHover,
    cursor: cursor,
    hitTestBehavior: hitTestBehavior,
    opaque: opaque,
    radius: radius,
    child: this,
  );
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
    super.cursor,
    super.hitTestBehavior = HitTestBehavior.opaque,
    super.opaque = true,
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
  CustomPainter get painter => RippleAreaPainter(
    center: center,
    ratio: controller.value,
    color: widget.colors.background,
  );

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
  @copy
  @lerp
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
  ) => _$lerp$RippleCardColors(a, b, t);

  final AreaColors ripple;
}
