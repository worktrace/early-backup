// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: LibraryAnnotationBuilder
// **************************************************************************

// ignore_for_file: implementation_imports generated.

import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

extension WrapAlign on Widget? {
  Align align({
    Key? key,
    AlignmentGeometry alignment = Alignment.center,
    double? widthFactor,
    double? heightFactor,
  }) {
    return Align(
      key: key,
      alignment: alignment,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: this,
    );
  }
}

extension WrapCenter on Widget? {
  Center center({Key? key, double? widthFactor, double? heightFactor}) {
    return Center(
      key: key,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: this,
    );
  }
}

extension WrapFocus on Widget {
  Focus focus({
    Key? key,
    FocusNode? focusNode,
    FocusNode? parentNode,
    bool autofocus = false,
    void Function(bool)? onFocusChange,
    KeyEventResult Function(FocusNode, KeyEvent)? onKeyEvent,
    KeyEventResult Function(FocusNode, RawKeyEvent)? onKey,
    bool? canRequestFocus,
    bool? skipTraversal,
    bool? descendantsAreFocusable,
    bool? descendantsAreTraversable,
    bool includeSemantics = true,
    String? debugLabel,
  }) {
    return Focus(
      key: key,
      child: this,
      focusNode: focusNode,
      parentNode: parentNode,
      autofocus: autofocus,
      onFocusChange: onFocusChange,
      onKeyEvent: onKeyEvent,
      onKey: onKey,
      canRequestFocus: canRequestFocus,
      skipTraversal: skipTraversal,
      descendantsAreFocusable: descendantsAreFocusable,
      descendantsAreTraversable: descendantsAreTraversable,
      includeSemantics: includeSemantics,
      debugLabel: debugLabel,
    );
  }
}

extension WrapPadding on Widget? {
  Padding padding({Key? key, required EdgeInsetsGeometry padding}) {
    return Padding(key: key, padding: padding, child: this);
  }
}

extension WrapTransform on Widget? {
  Transform transform({
    Key? key,
    required Matrix4 transform,
    Offset? origin,
    AlignmentGeometry? alignment,
    bool transformHitTests = true,
    FilterQuality? filterQuality,
  }) {
    return Transform(
      key: key,
      transform: transform,
      origin: origin,
      alignment: alignment,
      transformHitTests: transformHitTests,
      filterQuality: filterQuality,
      child: this,
    );
  }
}

extension WrapPositioned on Widget {
  Positioned position({
    Key? key,
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? width,
    double? height,
  }) {
    return Positioned(
      key: key,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      width: width,
      height: height,
      child: this,
    );
  }
}

extension WrapPositionedFill on Widget {
  Positioned positionFill({
    Key? key,
    double? left = 0.0,
    double? top = 0.0,
    double? right = 0.0,
    double? bottom = 0.0,
  }) {
    return Positioned.fill(
      key: key,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: this,
    );
  }
}

extension WrapPositionedFromRect on Widget {
  Positioned positionFromRect({Key? key, required Rect rect}) {
    return Positioned.fromRect(key: key, rect: rect, child: this);
  }
}

extension WrapPositionedDirectional on Widget {
  Positioned positionDirectional({
    Key? key,
    required TextDirection textDirection,
    double? start,
    double? top,
    double? end,
    double? bottom,
    double? width,
    double? height,
  }) {
    return Positioned.directional(
      key: key,
      textDirection: textDirection,
      start: start,
      top: top,
      end: end,
      bottom: bottom,
      width: width,
      height: height,
      child: this,
    );
  }
}

extension WrapGestureDetector on Widget? {
  GestureDetector gesture({
    Key? key,
    void Function(TapDownDetails)? onTapDown,
    void Function(TapUpDetails)? onTapUp,
    void Function()? onTap,
    void Function(TapMoveDetails)? onTapMove,
    void Function()? onTapCancel,
    void Function()? onSecondaryTap,
    void Function(TapDownDetails)? onSecondaryTapDown,
    void Function(TapUpDetails)? onSecondaryTapUp,
    void Function()? onSecondaryTapCancel,
    void Function(TapDownDetails)? onTertiaryTapDown,
    void Function(TapUpDetails)? onTertiaryTapUp,
    void Function()? onTertiaryTapCancel,
    void Function(TapDownDetails)? onDoubleTapDown,
    void Function()? onDoubleTap,
    void Function()? onDoubleTapCancel,
    void Function(LongPressDownDetails)? onLongPressDown,
    void Function()? onLongPressCancel,
    void Function()? onLongPress,
    void Function(LongPressStartDetails)? onLongPressStart,
    void Function(LongPressMoveUpdateDetails)? onLongPressMoveUpdate,
    void Function()? onLongPressUp,
    void Function(LongPressEndDetails)? onLongPressEnd,
    void Function(LongPressDownDetails)? onSecondaryLongPressDown,
    void Function()? onSecondaryLongPressCancel,
    void Function()? onSecondaryLongPress,
    void Function(LongPressStartDetails)? onSecondaryLongPressStart,
    void Function(LongPressMoveUpdateDetails)? onSecondaryLongPressMoveUpdate,
    void Function()? onSecondaryLongPressUp,
    void Function(LongPressEndDetails)? onSecondaryLongPressEnd,
    void Function(LongPressDownDetails)? onTertiaryLongPressDown,
    void Function()? onTertiaryLongPressCancel,
    void Function()? onTertiaryLongPress,
    void Function(LongPressStartDetails)? onTertiaryLongPressStart,
    void Function(LongPressMoveUpdateDetails)? onTertiaryLongPressMoveUpdate,
    void Function()? onTertiaryLongPressUp,
    void Function(LongPressEndDetails)? onTertiaryLongPressEnd,
    void Function(DragDownDetails)? onVerticalDragDown,
    void Function(DragStartDetails)? onVerticalDragStart,
    void Function(DragUpdateDetails)? onVerticalDragUpdate,
    void Function(DragEndDetails)? onVerticalDragEnd,
    void Function()? onVerticalDragCancel,
    void Function(DragDownDetails)? onHorizontalDragDown,
    void Function(DragStartDetails)? onHorizontalDragStart,
    void Function(DragUpdateDetails)? onHorizontalDragUpdate,
    void Function(DragEndDetails)? onHorizontalDragEnd,
    void Function()? onHorizontalDragCancel,
    void Function(ForcePressDetails)? onForcePressStart,
    void Function(ForcePressDetails)? onForcePressPeak,
    void Function(ForcePressDetails)? onForcePressUpdate,
    void Function(ForcePressDetails)? onForcePressEnd,
    void Function(DragDownDetails)? onPanDown,
    void Function(DragStartDetails)? onPanStart,
    void Function(DragUpdateDetails)? onPanUpdate,
    void Function(DragEndDetails)? onPanEnd,
    void Function()? onPanCancel,
    void Function(ScaleStartDetails)? onScaleStart,
    void Function(ScaleUpdateDetails)? onScaleUpdate,
    void Function(ScaleEndDetails)? onScaleEnd,
    HitTestBehavior? behavior,
    bool excludeFromSemantics = false,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    bool trackpadScrollCausesScale = false,
    Offset trackpadScrollToScaleFactor = kDefaultTrackpadScrollToScaleFactor,
    Set<PointerDeviceKind>? supportedDevices,
  }) {
    return GestureDetector(
      key: key,
      child: this,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTap: onTap,
      onTapMove: onTapMove,
      onTapCancel: onTapCancel,
      onSecondaryTap: onSecondaryTap,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onDoubleTapDown: onDoubleTapDown,
      onDoubleTap: onDoubleTap,
      onDoubleTapCancel: onDoubleTapCancel,
      onLongPressDown: onLongPressDown,
      onLongPressCancel: onLongPressCancel,
      onLongPress: onLongPress,
      onLongPressStart: onLongPressStart,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressUp: onLongPressUp,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPressDown: onSecondaryLongPressDown,
      onSecondaryLongPressCancel: onSecondaryLongPressCancel,
      onSecondaryLongPress: onSecondaryLongPress,
      onSecondaryLongPressStart: onSecondaryLongPressStart,
      onSecondaryLongPressMoveUpdate: onSecondaryLongPressMoveUpdate,
      onSecondaryLongPressUp: onSecondaryLongPressUp,
      onSecondaryLongPressEnd: onSecondaryLongPressEnd,
      onTertiaryLongPressDown: onTertiaryLongPressDown,
      onTertiaryLongPressCancel: onTertiaryLongPressCancel,
      onTertiaryLongPress: onTertiaryLongPress,
      onTertiaryLongPressStart: onTertiaryLongPressStart,
      onTertiaryLongPressMoveUpdate: onTertiaryLongPressMoveUpdate,
      onTertiaryLongPressUp: onTertiaryLongPressUp,
      onTertiaryLongPressEnd: onTertiaryLongPressEnd,
      onVerticalDragDown: onVerticalDragDown,
      onVerticalDragStart: onVerticalDragStart,
      onVerticalDragUpdate: onVerticalDragUpdate,
      onVerticalDragEnd: onVerticalDragEnd,
      onVerticalDragCancel: onVerticalDragCancel,
      onHorizontalDragDown: onHorizontalDragDown,
      onHorizontalDragStart: onHorizontalDragStart,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd,
      onHorizontalDragCancel: onHorizontalDragCancel,
      onForcePressStart: onForcePressStart,
      onForcePressPeak: onForcePressPeak,
      onForcePressUpdate: onForcePressUpdate,
      onForcePressEnd: onForcePressEnd,
      onPanDown: onPanDown,
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      onPanCancel: onPanCancel,
      onScaleStart: onScaleStart,
      onScaleUpdate: onScaleUpdate,
      onScaleEnd: onScaleEnd,
      behavior: behavior,
      excludeFromSemantics: excludeFromSemantics,
      dragStartBehavior: dragStartBehavior,
      trackpadScrollCausesScale: trackpadScrollCausesScale,
      trackpadScrollToScaleFactor: trackpadScrollToScaleFactor,
      supportedDevices: supportedDevices,
    );
  }
}

extension WrapMouseRegion on Widget? {
  MouseRegion mouse({
    Key? key,
    void Function(PointerEnterEvent)? onEnter,
    void Function(PointerExitEvent)? onExit,
    void Function(PointerHoverEvent)? onHover,
    MouseCursor cursor = MouseCursor.defer,
    bool opaque = true,
    HitTestBehavior? hitTestBehavior,
  }) {
    return MouseRegion(
      key: key,
      onEnter: onEnter,
      onExit: onExit,
      onHover: onHover,
      cursor: cursor,
      opaque: opaque,
      hitTestBehavior: hitTestBehavior,
      child: this,
    );
  }
}
