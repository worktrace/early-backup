import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:state_reuse/state_reuse.dart';
import 'package:wrap/wrap.dart';

const kRippleDuration = Duration(milliseconds: 245);
const kRippleAnimation = AnimationDefibrillation(duration: kRippleDuration);

abstract class RippleBase extends AnimatedMouseWidget {
  const RippleBase({
    super.key,
    super.animation = kRippleAnimation,
    this.hold = false,
    super.onEnter,
    super.onExit,
    super.onHover,
    super.opaque,
    super.hitTestBehavior,
    this.child,
  });

  final bool hold;
  final Widget? child;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('hold', hold));
  }
}

abstract class RipplePainter extends CustomPainter {
  const RipplePainter({
    this.center = Offset.zero,
    this.ratio = 0,
    this.color = transparent,
  });

  final Offset center;
  final double ratio;
  final Color color;

  @override
  bool shouldRepaint(covariant RipplePainter oldDelegate) =>
      center != oldDelegate.center ||
      ratio != oldDelegate.ratio ||
      color != oldDelegate.color;
}
