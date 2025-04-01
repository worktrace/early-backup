import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

extension WrapFocus on Widget {
  Focus focus({
    Key? key,
    FocusNode? focusNode,
    FocusNode? parentNode,
    bool autofocus = false,
    ValueChanged<bool>? onFocusChange,
    FocusOnKeyEventCallback? onKeyEvent,
    bool? canRequestFocus,
    bool? skipTraversal,
    bool? descendantsAreFocusable,
    bool? descendantsAreTraversable,
    bool includeSemantics = true,
    String? debugLabel,
  }) => Focus(
    key: key,
    focusNode: focusNode,
    parentNode: parentNode,
    autofocus: autofocus,
    onFocusChange: onFocusChange,
    onKeyEvent: onKeyEvent,
    canRequestFocus: canRequestFocus,
    skipTraversal: skipTraversal,
    descendantsAreFocusable: descendantsAreFocusable,
    descendantsAreTraversable: descendantsAreTraversable,
    includeSemantics: includeSemantics,
    debugLabel: debugLabel,
    child: this,
  );
}

extension WrapInteract on Widget? {
  MouseRegion mouse({
    Key? key,
    PointerEnterEventListener? onEnter,
    PointerExitEventListener? onExit,
    PointerHoverEventListener? onHover,
    MouseCursor cursor = MouseCursor.defer,
    bool opaque = true,
    HitTestBehavior? hitTestBehavior,
  }) => MouseRegion(
    key: key,
    onEnter: onEnter,
    onExit: onExit,
    onHover: onHover,
    cursor: cursor,
    opaque: opaque,
    hitTestBehavior: hitTestBehavior,
    child: this,
  );

  GestureDetector gesture({
    Key? key,

    // Tap.
    GestureTapCallback? onTap,
    GestureTapDownCallback? onTapDown,
    GestureTapUpCallback? onTapUp,
    GestureTapCancelCallback? onTapCancel,

    // Secondary tap.
    GestureTapCallback? onSecondaryTap,
    GestureTapDownCallback? onSecondaryTapDown,
    GestureTapUpCallback? onSecondaryTapUp,
    GestureTapCancelCallback? onSecondaryTapCancel,

    // Tertiary tap.
    GestureTapDownCallback? onTertiaryTapDown,
    GestureTapUpCallback? onTertiaryTapUp,
    GestureTapCancelCallback? onTertiaryTapCancel,

    // Double tap.
    GestureTapCallback? onDoubleTap,
    GestureTapDownCallback? onDoubleTapDown,
    GestureTapCancelCallback? onDoubleTapCancel,

    // Long press.
    GestureLongPressCallback? onLongPress,
    GestureLongPressDownCallback? onLongPressDown,
    GestureLongPressCancelCallback? onLongPressCancel,
    GestureLongPressStartCallback? onLongPressStart,
    GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate,
    GestureLongPressUpCallback? onLongPressUp,
    GestureLongPressEndCallback? onLongPressEnd,

    // Secondary long press.
    GestureLongPressCallback? onSecondaryLongPress,
    GestureLongPressDownCallback? onSecondaryLongPressDown,
    GestureLongPressCancelCallback? onSecondaryLongPressCancel,
    GestureLongPressStartCallback? onSecondaryLongPressStart,
    GestureLongPressMoveUpdateCallback? onSecondaryLongPressMoveUpdate,
    GestureLongPressUpCallback? onSecondaryLongPressUp,
    GestureLongPressEndCallback? onSecondaryLongPressEnd,

    // Tertiary long press.
    GestureLongPressCallback? onTertiaryLongPress,
    GestureLongPressDownCallback? onTertiaryLongPressDown,
    GestureLongPressCancelCallback? onTertiaryLongPressCancel,
    GestureLongPressStartCallback? onTertiaryLongPressStart,
    GestureLongPressMoveUpdateCallback? onTertiaryLongPressMoveUpdate,
    GestureLongPressUpCallback? onTertiaryLongPressUp,
    GestureLongPressEndCallback? onTertiaryLongPressEnd,

    // Vertical drag.
    GestureDragDownCallback? onVerticalDragDown,
    GestureDragStartCallback? onVerticalDragStart,
    GestureDragUpdateCallback? onVerticalDragUpdate,
    GestureDragEndCallback? onVerticalDragEnd,
    GestureDragCancelCallback? onVerticalDragCancel,

    // Horizontal drag.
    GestureDragDownCallback? onHorizontalDragDown,
    GestureDragStartCallback? onHorizontalDragStart,
    GestureDragUpdateCallback? onHorizontalDragUpdate,
    GestureDragEndCallback? onHorizontalDragEnd,
    GestureDragCancelCallback? onHorizontalDragCancel,

    // Force press.
    GestureForcePressStartCallback? onForcePressStart,
    GestureForcePressPeakCallback? onForcePressPeak,
    GestureForcePressUpdateCallback? onForcePressUpdate,
    GestureForcePressEndCallback? onForcePressEnd,

    // Pan.
    GestureDragDownCallback? onPanDown,
    GestureDragStartCallback? onPanStart,
    GestureDragUpdateCallback? onPanUpdate,
    GestureDragEndCallback? onPanEnd,
    GestureDragCancelCallback? onPanCancel,

    // Scale.
    GestureScaleStartCallback? onScaleStart,
    GestureScaleUpdateCallback? onScaleUpdate,
    GestureScaleEndCallback? onScaleEnd,

    // Configurations.
    HitTestBehavior? behavior,
    bool excludeFromSemantics = false,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    bool trackpadScrollCausesScale = false,
    Offset trackpadScrollToScaleFactor = kDefaultTrackpadScrollToScaleFactor,
    Set<PointerDeviceKind>? supportedDevices,
  }) => GestureDetector(
    key: key,

    // Tap.
    onTapDown: onTapDown,
    onTapUp: onTapUp,
    onTap: onTap,
    onTapCancel: onTapCancel,

    // Secondary Tap.
    onSecondaryTap: onSecondaryTap,
    onSecondaryTapDown: onSecondaryTapDown,
    onSecondaryTapUp: onSecondaryTapUp,
    onSecondaryTapCancel: onSecondaryTapCancel,

    // Tertiary Tap.
    onTertiaryTapDown: onTertiaryTapDown,
    onTertiaryTapUp: onTertiaryTapUp,
    onTertiaryTapCancel: onTertiaryTapCancel,

    // Double Tap.
    onDoubleTapDown: onDoubleTapDown,
    onDoubleTap: onDoubleTap,
    onDoubleTapCancel: onDoubleTapCancel,

    // Long press.
    onLongPressDown: onLongPressDown,
    onLongPressCancel: onLongPressCancel,
    onLongPress: onLongPress,
    onLongPressStart: onLongPressStart,
    onLongPressMoveUpdate: onLongPressMoveUpdate,
    onLongPressUp: onLongPressUp,
    onLongPressEnd: onLongPressEnd,

    // Secondary long press.
    onSecondaryLongPressDown: onSecondaryLongPressDown,
    onSecondaryLongPressCancel: onSecondaryLongPressCancel,
    onSecondaryLongPress: onSecondaryLongPress,
    onSecondaryLongPressStart: onSecondaryLongPressStart,
    onSecondaryLongPressMoveUpdate: onSecondaryLongPressMoveUpdate,
    onSecondaryLongPressUp: onSecondaryLongPressUp,
    onSecondaryLongPressEnd: onSecondaryLongPressEnd,

    // Tertiary long press.
    onTertiaryLongPressDown: onTertiaryLongPressDown,
    onTertiaryLongPressCancel: onTertiaryLongPressCancel,
    onTertiaryLongPress: onTertiaryLongPress,
    onTertiaryLongPressStart: onTertiaryLongPressStart,
    onTertiaryLongPressMoveUpdate: onTertiaryLongPressMoveUpdate,
    onTertiaryLongPressUp: onTertiaryLongPressUp,
    onTertiaryLongPressEnd: onTertiaryLongPressEnd,

    // Vertical drag.
    onVerticalDragDown: onVerticalDragDown,
    onVerticalDragStart: onVerticalDragStart,
    onVerticalDragUpdate: onVerticalDragUpdate,
    onVerticalDragEnd: onVerticalDragEnd,
    onVerticalDragCancel: onVerticalDragCancel,

    // Horizontal drag.
    onHorizontalDragDown: onHorizontalDragDown,
    onHorizontalDragStart: onHorizontalDragStart,
    onHorizontalDragUpdate: onHorizontalDragUpdate,
    onHorizontalDragEnd: onHorizontalDragEnd,
    onHorizontalDragCancel: onHorizontalDragCancel,

    // Force press.
    onForcePressStart: onForcePressStart,
    onForcePressPeak: onForcePressPeak,
    onForcePressUpdate: onForcePressUpdate,
    onForcePressEnd: onForcePressEnd,

    // Pan.
    onPanDown: onPanDown,
    onPanStart: onPanStart,
    onPanUpdate: onPanUpdate,
    onPanEnd: onPanEnd,
    onPanCancel: onPanCancel,

    // Scale.
    onScaleStart: onScaleStart,
    onScaleUpdate: onScaleUpdate,
    onScaleEnd: onScaleEnd,

    // Configurations.
    behavior: behavior,
    excludeFromSemantics: excludeFromSemantics,
    dragStartBehavior: dragStartBehavior,
    trackpadScrollCausesScale: trackpadScrollCausesScale,
    trackpadScrollToScaleFactor: trackpadScrollToScaleFactor,
    supportedDevices: supportedDevices,

    child: this,
  );
}
