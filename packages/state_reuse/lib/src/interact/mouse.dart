import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:state_reuse/animation.dart';

abstract class AnimatedMouseWidget extends MouseWidget {
  const AnimatedMouseWidget({
    super.key,
    this.animation = const AnimationDefibrillation(),
    super.onEnter,
    super.onExit,
    super.onHover,
    super.cursor,
    super.opaque,
    super.hitTestBehavior,
    super.child,
  });

  final AnimationDefibrillation animation;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<AnimationDefibrillation>('animation', animation),
    );
  }
}

abstract class MouseWidget extends StatefulWidget {
  const MouseWidget({
    super.key,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.cursor = MouseCursor.defer,
    this.opaque = true,
    this.hitTestBehavior,
    this.child,
  });

  final PointerEnterEventListener? onEnter;
  final PointerExitEventListener? onExit;
  final PointerHoverEventListener? onHover;
  final MouseCursor cursor;
  final bool opaque;
  final HitTestBehavior? hitTestBehavior;

  final Widget? child;

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
