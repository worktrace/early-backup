import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:wrap/wrap.dart';

import 'animation_data.dart';
import 'animation_reuse.dart';

class AnimatedPaint extends StatefulWidget {
  const AnimatedPaint({
    super.key,
    this.animation = const AnimationData(),
    this.painter,
    this.foregroundPainter,
    this.backPainter,
    this.foregroundBackPainter,
    this.child,
  });

  final AnimationData animation;
  final AnimatedPainter? painter;
  final AnimatedPainter? foregroundPainter;
  final AnimatedPainter? backPainter;
  final AnimatedPainter? foregroundBackPainter;
  final Widget? child;

  @override
  State<AnimatedPaint> createState() => _AnimatedPaintState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final f = foregroundPainter;
    final b = foregroundBackPainter;
    properties
      ..add(DiagnosticsProperty<AnimationData>('animation', animation))
      ..add(DiagnosticsProperty<AnimatedPainter?>('painter', painter))
      ..add(DiagnosticsProperty<AnimatedPainter?>('foregroundPainter', f))
      ..add(DiagnosticsProperty<AnimatedPainter?>('backPainter', backPainter))
      ..add(DiagnosticsProperty<AnimatedPainter?>('foregroundBackPainter', b));
  }
}

class _AnimatedPaintState extends SingleAnimationState<AnimatedPaint> {
  @override
  Widget build(BuildContext context) => widget.child.paint();
}

abstract class AnimatedPainter extends CustomPainter {
  const AnimatedPainter({this.value = 0});

  final double value;

  @override
  @mustCallSuper
  bool shouldRepaint(covariant AnimatedPainter oldDelegate) {
    return value != oldDelegate.value;
  }
}
