import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:state_reuse/animation.dart';
import 'package:wrap/wrap.dart';

import 'mouse.dart';

class HoverDefibrillation extends MouseWidget {
  const HoverDefibrillation({
    super.key,
    this.defibrillation = kHoverDefibrillation,
    super.onEnter,
    super.onExit,
    super.onHover,
    super.cursor,
    super.hitTestBehavior,
    super.opaque,
    super.child,
  });

  final Duration defibrillation;

  @override
  State<HoverDefibrillation> createState() => _HoverDefibrillationState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final d = defibrillation;
    properties.add(DiagnosticsProperty<Duration>('defibrillation', d));
  }
}

class _HoverDefibrillationState extends State<HoverDefibrillation> {
  var _hover = false;
  var _resolvedHover = false;

  Future<void> _mouseEnter(PointerEnterEvent event) async {
    _hover = true;
    await Future<void>.delayed(widget.defibrillation);
    if (!_hover) return;
    _resolvedHover = true;
    widget.onEnter?.call(event);
  }

  Future<void> _mouseExit(PointerExitEvent event) async {
    _hover = false;
    await Future<void>.delayed(widget.defibrillation);
    if (_hover) return;
    _resolvedHover = false;
    widget.onExit?.call(event);
  }

  @override
  Widget build(BuildContext context) => widget.child!.mouse(
    onEnter: _mouseEnter,
    onExit: _mouseExit,
    onHover: widget.onHover,
    cursor: _resolvedHover ? widget.cursor : MouseCursor.defer,
    opaque: widget.opaque,
    hitTestBehavior: widget.hitTestBehavior,
  );
}
