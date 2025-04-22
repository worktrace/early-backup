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

  /// Called when defibrillation-resolved mouse enter.
  void mouseEnter(PointerEnterEvent event) {}

  /// Called when defibrillation-resolved mouse exit.
  void mouseExit(PointerExitEvent event) {}

  Future<void> _mouseEnter(PointerEnterEvent event) async {
    _hover = true;
    await Future<void>.delayed(defibrillation);
    if (!_hover) return;
    setState(() => _resolvedHover = true);
    mouseEnter(event);
    widget.onEnter?.call(event);
  }

  Future<void> _mouseExit(PointerExitEvent event) async {
    _hover = false;
    await Future<void>.delayed(defibrillation);
    if (_hover) return;
    setState(() => _resolvedHover = false);
    mouseExit(event);
    widget.onExit?.call(event);
  }

  /// Override this method to define how to build the widget.
  /// This method is like the [build] method in most [State]s,
  /// but here the [build] method is used to wrap mouse bindings,
  /// so that it's supposed to override this method to define how to build.
  Widget? render(BuildContext context);

  /// Use [render] instead,
  /// it's strongly not recommended to override this method here.
  @protected
  @override
  Widget build(BuildContext context) => render(context).mouse(
    onEnter: _mouseEnter,
    onExit: _mouseExit,
    onHover: widget.onHover,
    cursor: _resolvedHover ? widget.cursor : MouseCursor.defer,
    hitTestBehavior: widget.hitTestBehavior,
    opaque: widget.opaque,
  );

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
  Widget? render(BuildContext context) => widget.child;
}
