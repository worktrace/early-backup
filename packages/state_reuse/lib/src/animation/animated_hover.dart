import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:state_reuse/binding.dart';
import 'package:state_reuse/interact.dart';

import 'animation_data.dart';
import 'animation_reuse.dart';

class AnimatedHover extends MouseWidgetBase {
  const AnimatedHover({
    super.key,
    this.animation = const AnimationDefibrillation(),
    super.onEnter,
    super.onExit,
    super.onHover,
    super.cursor,
    super.hitTestBehavior,
    super.opaque,
    required this.builder,
  });

  final AnimationDefibrillation animation;
  final DataBuilder<double> builder;

  @override
  State<AnimatedHover> createState() => _AnimatedHoverState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final a = animation;
    properties
      ..add(DiagnosticsProperty<AnimationDefibrillation>('animation', a))
      ..add(ObjectFlagProperty<DataBuilder<double>>.has('builder', builder));
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
