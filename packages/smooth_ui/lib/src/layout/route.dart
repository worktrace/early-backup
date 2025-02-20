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

extension WrapRouteAnimation on Widget {
  RouteAnimation routeAnimation({
    Key? key,
    AnimationData animation = const AnimationData(),
    RouteCompare? compare,
    required RouteRenderer renderer,
  }) {
    return RouteAnimation(
      key: key,
      animation: animation,
      compare: compare,
      renderer: renderer,
      child: this,
    );
  }
}

/// Play route animation when [child] has changed.
///
/// This widget is designed to provide more flexible control over
/// the route animation regardless of the routers provided by packages
/// such as `go_router`.
///
/// 1. Specify the [compare] function to determine whether to play animation.
/// 2. Specify [renderer] function to tell how to render the change animation.
class RouteAnimation extends SingleAnimationWidget {
  const RouteAnimation({
    super.key,
    super.animation,
    this.compare,
    required this.renderer,
    required this.child,
  });

  final RouteCompare? compare;
  final RouteRenderer renderer;
  final Widget child;

  @override
  State<RouteAnimation> createState() => _RouteAnimationState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final r = renderer;
    properties
      ..add(ObjectFlagProperty<RouteCompare>.has('compare', compare))
      ..add(ObjectFlagProperty<RouteRenderer>.has('animationBuilder', r));
  }
}

class _RouteAnimationState extends SingleAnimationState<RouteAnimation> {
  late Widget? _oldChild;
  late Widget _child = widget.child;

  /// Resolve with default compare function.
  RouteCompare get compare => widget.compare ?? defaultCompare;

  /// Play route animation only when runtime type of current widget has changed.
  /// This strategy is most commonly used and will avoid unnecessary route
  /// animation when only data has changed.
  static bool defaultCompare(Widget current, Widget previous) {
    return current.runtimeType == previous.runtimeType;
  }

  @override
  void didUpdateWidget(covariant RouteAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!compare(widget.child, _child)) unawaited(playAnimation());
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<RouteCompare>.has('compare', compare));
  }
}
