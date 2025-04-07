import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:state_reuse/interact.dart';
import 'package:wrap/wrap.dart';

import 'animation_data.dart';

class AnimatedHover extends MouseWidget {
  const AnimatedHover({
    super.key,
    this.animation = const AnimationDefibrillation(),
    super.onEnter,
    super.onExit,
    super.onHover,
    super.cursor,
    super.hitTestBehavior,
    super.opaque,
    super.child,
  });

  final AnimationDefibrillation animation;

  @override
  State<AnimatedHover> createState() => _AnimatedHoverState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final a = animation;
    properties.add(DiagnosticsProperty<AnimationDefibrillation>('anim', a));
  }
}

class _AnimatedHoverState extends State<AnimatedHover> {
  @override
  Widget build(BuildContext context) {
    return widget.child.mouse();
  }
}

abstract class AnimatedMouseWidget extends MouseWidget {
  const AnimatedMouseWidget({
    super.key,
    this.animation = const AnimationDefibrillation(),
    super.onEnter,
    super.onExit,
    super.onHover,
    super.cursor,
    super.opaque,
    super.hitTestBehavior,
    super.child,
  });

  final AnimationDefibrillation animation;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<AnimationDefibrillation>('animation', animation),
    );
  }
}
