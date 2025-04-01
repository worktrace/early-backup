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
  State<HoverDefibrillation> createState() => HoverDefibrillationState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final d = defibrillation;
    properties.add(DiagnosticsProperty<Duration>('defibrillation', d));
  }
}

class HoverDefibrillationState extends State<HoverDefibrillation> {
  var _hover = false;
  var _resolvedHover = false;

  bool get exactHover => _hover;
  bool get resolvedHover => _resolvedHover;

  Future<void> mouseEnter(PointerEnterEvent event) async {
    _hover = true;
    await Future<void>.delayed(widget.defibrillation);
    if (!_hover) return;
    _resolvedHover = true;
    widget.onEnter?.call(event);
  }

  Future<void> mouseExit(PointerExitEvent event) async {
    _hover = false;
    await Future<void>.delayed(widget.defibrillation);
    if (_hover) return;
    _resolvedHover = false;
    widget.onExit?.call(event);
  }

  @override
  Widget build(BuildContext context) => widget.child!.mouse(
    onEnter: mouseEnter,
    onExit: mouseExit,
    onHover: widget.onHover,
    cursor: _resolvedHover ? widget.cursor : MouseCursor.defer,
    opaque: widget.opaque,
    hitTestBehavior: widget.hitTestBehavior,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('exactHover', exactHover))
      ..add(DiagnosticsProperty<bool>('resolvedHover', resolvedHover));
  }
}
