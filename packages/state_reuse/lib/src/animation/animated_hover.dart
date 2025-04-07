import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:state_reuse/binding.dart';
import 'package:state_reuse/interact.dart';

import 'animation_data.dart';
import 'animation_reuse.dart';

abstract class AnimatedHoverBase extends MouseWidgetBase {
  const AnimatedHoverBase({
    super.key,
    this.animation = const AnimationDefibrillation(),
    super.onEnter,
    super.onExit,
    super.onHover,
    super.cursor,
    super.hitTestBehavior,
    super.opaque,
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

class AnimatedHover extends AnimatedHoverBase {
  const AnimatedHover({
    super.key,
    super.animation,
    super.onEnter,
    super.onExit,
    super.onHover,
    super.cursor,
    super.hitTestBehavior,
    super.opaque,
    required this.builder,
  });

  final DataBuilder<double> builder;

  @override
  State<AnimatedHover> createState() => _AnimatedHoverState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      ObjectFlagProperty<DataBuilder<double>>.has('builder', builder),
    );
  }
}

class _AnimatedHoverState extends State<AnimatedHover>
    with
        HoverDefibrillationMixin,
        SingleTickerProviderStateMixin,
        SingleAnimationMixin,
        SingleAnimationDefault {
  @override
  Duration get defibrillation => widget.animation.defibrillation;

  @override
  Widget render(BuildContext context) {
    return widget.builder(context, controller.value);
  }
}
