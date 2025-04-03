import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

abstract class MouseWidgetBase extends StatefulWidget {
  const MouseWidgetBase({
    super.key,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.cursor = MouseCursor.defer,
    this.opaque = true,
    this.hitTestBehavior,
  });

  final PointerEnterEventListener? onEnter;
  final PointerExitEventListener? onExit;
  final PointerHoverEventListener? onHover;
  final MouseCursor cursor;
  final bool opaque;
  final HitTestBehavior? hitTestBehavior;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final oe = onEnter;
    final oh = onHover;
    properties
      ..add(ObjectFlagProperty<PointerEnterEventListener?>.has('onEnter', oe))
      ..add(ObjectFlagProperty<PointerExitEventListener?>.has('onExit', onExit))
      ..add(ObjectFlagProperty<PointerHoverEventListener?>.has('onHover', oh))
      ..add(DiagnosticsProperty<MouseCursor>('cursor', cursor))
      ..add(DiagnosticsProperty<bool>('opaque', opaque))
      ..add(EnumProperty<HitTestBehavior?>('hitTestBehavior', hitTestBehavior));
  }
}

abstract class MouseWidget extends MouseWidgetBase {
  const MouseWidget({
    super.key,
    super.onEnter,
    super.onExit,
    super.onHover,
    super.cursor = MouseCursor.defer,
    super.opaque = true,
    super.hitTestBehavior,
    this.child,
  });

  final Widget? child;
}
