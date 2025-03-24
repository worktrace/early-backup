import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:state_reuse/state_reuse.dart';

import 'colors_data.dart';

extension WrapAdaptiveColors on Widget {
  AdaptiveColors<T> adaptiveColors<T extends ColorsBase>(
    ColorsAdapter<T> adapter, {
    Key? key,
  }) => AdaptiveColors<T>(
    key: key,
    adapter: adapter,
    builder: colorsAs<T>,
    child: this,
  );
}

typedef AdaptiveColors<T extends ColorsBase> =
    _AdaptiveColors<T, DataBuilder<T>>;

class _AdaptiveColors<T extends ColorsBase, U extends DataBuilder<T>>
    extends StatefulWidget {
  const _AdaptiveColors({
    super.key,
    required this.adapter,
    required this.builder,
    required this.child,
  });

  final ColorsAdapter<T> adapter;
  final U builder;
  final Widget child;

  @override
  State<_AdaptiveColors<T, U>> createState() => _AdaptiveColorsState<T, U>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ColorsAdapter<T>>('adapter', adapter))
      ..add(ObjectFlagProperty<DataBuilder<T>?>.has('renderer', builder));
  }
}

class _AdaptiveColorsState<T extends ColorsBase, U extends DataBuilder<T>>
    extends WidgetBindingState<_AdaptiveColors<T, U>> {
  late T _colors = widget.adapter.adapt;
  T get colors => _colors;
  set colors(T value) {
    if (_colors != value) setState(() => _colors = value);
  }

  @override
  void didUpdateWidget(covariant _AdaptiveColors<T, U> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.adapter != oldWidget.adapter) colors = widget.adapter.adapt;
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    colors = widget.adapter.adapt;
  }

  @override
  Widget build(BuildContext context) => widget.child.colorsAs(context, colors);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<T>('colors', colors));
  }
}

class ColorsAdapter<T extends ColorsBase> extends ColorsTween<T> {
  const ColorsAdapter({
    this.mode = ColorsMode.system,
    required super.dark,
    required super.light,
  });

  factory ColorsAdapter.from(ColorsTween<T> tween, ColorsMode mode) {
    return ColorsAdapter<T>(mode: mode, dark: tween.dark, light: tween.light);
  }

  final ColorsMode mode;

  T get adapt => mode.shouldDark ? dark : light;
}

class ColorsTween<T extends ColorsBase> {
  const ColorsTween({required this.dark, required this.light});

  final T dark;
  final T light;
}

/// Define how to apply color themes.
///
/// Similar to the `ThemeMode` defined in `package:flutter/material.dart`.
/// This enum is redefined here to avoid unnecessary import of
/// the `material` library.
enum ColorsMode {
  system,
  light,
  dark;

  bool get shouldDark {
    final b = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return this == system ? b == Brightness.dark : this == dark;
  }
}
