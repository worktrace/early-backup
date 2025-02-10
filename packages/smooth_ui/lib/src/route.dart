import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:state_reuse/state_reuse.dart';

typedef RouteAnimationBuilder = Widget Function(
  double value,
  Widget child,
  Widget oldChild,
);

class RouteContainer extends SingleAnimationWidget {
  const RouteContainer({
    super.key,
    super.animation,
    required this.animationBuilder,
    required this.child,
  });

  final RouteAnimationBuilder animationBuilder;
  final Widget child;

  @override
  State<RouteContainer> createState() => _RouteContainerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final a = animationBuilder;
    properties.add(
      ObjectFlagProperty<RouteAnimationBuilder>.has('animationBuilder', a),
    );
  }
}

class _RouteContainerState extends SingleAnimationState<RouteContainer> {
  @override
  void didUpdateWidget(covariant RouteContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.child != oldWidget.child) {}
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
