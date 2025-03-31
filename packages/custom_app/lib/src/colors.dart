import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_ui/themes.dart';
import 'package:state_reuse/animation.dart';
import 'package:state_reuse/binding.dart';
import 'package:wrap/wrap.dart';

const colorsAnimation = AnimationData(duration: Duration(milliseconds: 345));

extension WrapColors on Widget {
  Widget colorsAs<T extends ColorsBase>(BuildContext context, T colors) {
    return inherit(colors)
        .inherit(colors.brightness)
        .background(colors.background)
        .maybeForegroundAs(context, colors.foreground);
  }

  ColorsApply<T> colors<T extends ColorsBase>(T colors, {Key? key}) {
    return ColorsApply(key: key, colors: colors, child: this);
  }

  AdaptiveColors<T> adaptiveColors<T extends ColorsBase>(
    ColorsAdapter<T> adapter, {
    Key? key,
  }) {
    return AdaptiveColors<T>(
      key: key,
      adapter: adapter,
      builder: colorsAs<T>,
      child: this,
    );
  }

  SingleAnimation<T> animatedColors<T extends ColorsBase>(
    T colors,
    Lerp<T> lerp, {
    Key? key,
    AnimationData animation = const AnimationData(),
  }) {
    return SingleAnimation(
      key: key,
      animation: animation,
      data: colors,
      lerp: lerp,
      builder: colorsAs<T>,
    );
  }

  Widget maybeAnimatedColors<T extends ColorsBase>(
    T colors, {
    Key? key,
    Lerp<T>? lerp,
    AnimationData animation = const AnimationData(),
  }) {
    return lerp != null
        ? animatedColors<T>(colors, lerp, key: key, animation: animation)
        : this.colors(colors, key: key);
  }

  AdaptiveColors<T> adaptiveAnimatedColors<T extends ColorsBase>(
    ColorsAdapter<T> adapter,
    Lerp<T> lerp, {
    Key? key,
    AnimationData animation = colorsAnimation,
  }) {
    return AdaptiveColors<T>(
      key: key,
      adapter: adapter,
      builder: (_, t) => animatedColors<T>(t, lerp, animation: animation),
      child: this,
    );
  }

  AdaptiveColors<T> adaptiveMaybeAnimatedColors<T extends ColorsBase>(
    ColorsAdapter<T> adapter, {
    Key? key,
    Lerp<T>? lerp,
    AnimationData animation = colorsAnimation,
  }) {
    if (lerp == null) return adaptiveColors<T>(adapter, key: key);
    return adaptiveAnimatedColors<T>(
      adapter,
      lerp,
      key: key,
      animation: animation,
    );
  }
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

class ColorsApply<T extends ColorsBase> extends StatelessWidget {
  const ColorsApply({super.key, required this.colors, required this.child});

  final T colors;
  final Widget child;

  @override
  Widget build(BuildContext context) => child.colorsAs(context, colors);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<T>('colors', colors));
  }
}

abstract class ColorsBase extends AreaColors {
  const ColorsBase.light({
    required super.foreground,
    required super.background,
    this.brightness = Brightness.light,
  });

  const ColorsBase.dark({
    required super.foreground,
    required super.background,
    this.brightness = Brightness.dark,
  });

  final Brightness brightness;
}
