import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:state_reuse/state_reuse.dart';

typedef RouteCompare = bool Function(Widget current, Widget previous);

typedef RouteRenderer = Widget Function(
  double value,
  Widget child,
  Widget oldChild,
);

class RouteContainer extends SingleAnimationWidget {
  const RouteContainer({
    super.key,
    super.animation,
    required this.compare,
    required this.renderer,
    required this.child,
  });

  final RouteCompare compare;
  final RouteRenderer renderer;
  final Widget child;

  @override
  State<RouteContainer> createState() => _RouteContainerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final r = renderer;
    properties
      ..add(ObjectFlagProperty<RouteCompare>.has('compare', compare))
      ..add(ObjectFlagProperty<RouteRenderer>.has('animationBuilder', r));
  }
}

class _RouteContainerState extends SingleAnimationState<RouteContainer> {
  late Widget? _oldChild;
  late Widget _child = widget.child;

  @override
  void didUpdateWidget(covariant RouteContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.compare(widget.child, _child)) unawaited(playAnimation());
  }

  Future<void> playAnimation() async {
    _oldChild = _child;
    _child = widget.child;
    await controller.animateAs(widget.animation, 1);
    _oldChild = null;
    controller.reset();
  }

  @override
  Widget build(BuildContext context) => controller.isAnimating
      ? widget.renderer(controller.value, _child, _oldChild!)
      : widget.child;
}
