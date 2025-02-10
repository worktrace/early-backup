import 'package:flutter/widgets.dart';
import 'package:state_reuse/state_reuse.dart';

class RouteContainer extends SingleAnimationWidget {
  const RouteContainer({
    super.key,
    super.animation,
    required this.child,
  });

  final Widget child;

  @override
  State<RouteContainer> createState() => _RouteContainerState();
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
