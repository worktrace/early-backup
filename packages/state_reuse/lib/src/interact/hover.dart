import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:state_reuse/animation.dart';
import 'package:wrap/wrap.dart';

import 'mouse.dart';

abstract class HoverDefibrillationBase extends MouseWidgetBase {
  const HoverDefibrillationBase({
    super.key,
    this.defibrillation = kHoverDefibrillation,
    super.onEnter,
    super.onExit,
    super.onHover,
    super.cursor,
    super.hitTestBehavior,
    super.opaque,
  });

  final Duration defibrillation;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final d = defibrillation;
    properties.add(DiagnosticsProperty<Duration>('defibrillation', d));
  }
}

mixin HoverDefibrillationMixin<W extends MouseWidgetBase> on State<W> {
  Duration get defibrillation;

  var _hover = false;
  var _resolvedHover = false;

  bool get exactHover => _hover;
  bool get resolvedHover => _resolvedHover;

  Future<void> mouseEnter(PointerEnterEvent event) async {
    _hover = true;
    await Future<void>.delayed(defibrillation);
    if (!_hover) return;
    _resolvedHover = true;
    widget.onEnter?.call(event);
  }

  Future<void> mouseExit(PointerExitEvent event) async {
    _hover = false;
    await Future<void>.delayed(defibrillation);
    if (_hover) return;
    _resolvedHover = false;
    widget.onExit?.call(event);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Duration>('defibrillation', defibrillation))
      ..add(DiagnosticsProperty<bool>('exactHover', exactHover))
      ..add(DiagnosticsProperty<bool>('resolvedHover', resolvedHover));
  }
}

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
    properties.add(
      DiagnosticsProperty<Duration>('defibrillation', defibrillation),
    );
  }
}

class _HoverDefibrillationState extends State<HoverDefibrillation>
    with HoverDefibrillationMixin {
  @override
  Duration get defibrillation => widget.defibrillation;

  @override
  Widget build(BuildContext context) => widget.child.mouse(
    onEnter: mouseEnter,
    onExit: mouseExit,
    onHover: widget.onHover,
    cursor: _resolvedHover ? widget.cursor : MouseCursor.defer,
    opaque: widget.opaque,
    hitTestBehavior: widget.hitTestBehavior,
  );
}
