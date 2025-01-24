import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:state_reuse/state_reuse.dart';
import 'package:wrap/wrap.dart';

const kRippleColor = Color.fromARGB(255, 8, 140, 222);
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

abstract class RippleBaseState<S extends RippleBase>
    extends SingleAnimationState<S> {
  @override
  @mustCallSuper
  void initState() {
    super.initState();
    controller.addStatusListener(_resolveAnimationComplete);
  }

  Offset _center = Offset.zero;
  Offset get center => _center;

  bool get hover => _resolvedHover;
  var _hover = false;
  var _resolvedHover = false;
  Offset _tempCenter = Offset.zero;

  Future<void> _resolveAnimationComplete(AnimationStatus status) async {
    if (status == AnimationStatus.completed && !hover) {
      await _removeRippleAnim();
    }
  }

  Future<void> _removeRippleAnim() {
    setState(() => _center = _tempCenter);
    return controller.animateToStart(widget.animation);
  }

  Future<void> _mouseEnter(PointerEnterEvent event) async {
    _hover = true;
    await Future<void>.delayed(widget.animation.defibrillation);
    if (!_hover || !mounted) return;

    _resolvedHover = true;
    widget.onEnter?.call(event);
    setState(() => _center = event.localPosition);
    return controller.animateToEnd(widget.animation);
  }

  Future<void> _mouseExit(PointerExitEvent event) async {
    _hover = false;
    await Future<void>.delayed(widget.animation.defibrillation);
    if (_hover || !mounted) return;

    _resolvedHover = false;
    widget.onExit?.call(event);
    if (controller.isCompleted && !widget.hold) {
      setState(() => _center = event.localPosition);
      return controller.animateToStart(widget.animation);
    }
    _tempCenter = event.localPosition;
  }

  @override
  void didUpdateWidget(covariant S oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hold && !widget.hold) unawaited(_removeRippleAnim());
  }

  CustomPainter get painter;

  @override
  @mustCallSuper
  Widget build(BuildContext context) =>
      widget.child.paint(painter: painter).mouse(
            onEnter: _mouseEnter,
            onExit: _mouseExit,
            onHover: widget.onHover,
            opaque: widget.opaque,
            hitTestBehavior: widget.hitTestBehavior,
          );

  @override
  @mustCallSuper
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Offset>('center', center))
      ..add(DiagnosticsProperty<bool>('hover', hover))
      ..add(DiagnosticsProperty<CustomPainter>('painter', painter));
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
