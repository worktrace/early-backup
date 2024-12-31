import 'package:auto_stories/src/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'binding.dart';

extension WrapColorTheme on Widget {
  Widget colorThemeAs<T extends ColorThemeBase>(BuildContext context, T theme) {
    return inherit(theme)
        .inherit(theme.brightness)
        .background(theme.background)
        .maybeForegroundAs(context, theme.foreground);
  }

  ColorThemeApply<T> colorTheme<T extends ColorThemeBase>(T theme, {Key? key}) {
    return ColorThemeApply(
      key: key,
      theme: theme,
      child: this,
    );
  }

  AdaptiveColorTheme<T> adaptiveColorTheme<T extends ColorThemeBase>(
    ColorThemeAdapter<T> adapter, {
    Key? key,
  }) {
    return AdaptiveColorTheme<T>(
      key: key,
      adapter: adapter,
      builder: colorThemeAs<T>,
      child: this,
    );
  }

  SingleAnimation<T> animatedColorTheme<T extends ColorThemeBase>(
    T theme,
    Lerp<T> lerp, {
    Key? key,
    AnimationData animation = const AnimationData(),
  }) {
    return SingleAnimation(
      key: key,
      animation: animation,
      data: theme,
      lerp: lerp,
      builder: colorThemeAs<T>,
    );
  }

  AdaptiveColorTheme<T> adaptiveAnimatedColorTheme<T extends ColorThemeBase>(
    ColorThemeAdapter<T> adapter,
    Lerp<T> lerp, {
    Key? key,
    AnimationData animation = const AnimationData(
      duration: Duration(milliseconds: 345),
    ),
  }) {
    return AdaptiveColorTheme<T>(
      key: key,
      adapter: adapter,
      builder: (context, theme) {
        return animatedColorTheme<T>(theme, lerp, animation: animation);
      },
      child: this,
    );
  }
}

class AdaptiveColorTheme<T extends ColorThemeBase> extends StatefulWidget {
  const AdaptiveColorTheme({
    super.key,
    required this.adapter,
    required this.builder,
    required this.child,
  });

  final ColorThemeAdapter<T> adapter;
  final DataBuilder<T> builder;
  final Widget child;

  @override
  State<AdaptiveColorTheme<T>> createState() => _AdaptiveColorThemeState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ColorThemeAdapter<T>>('adapter', adapter))
      ..add(ObjectFlagProperty<DataBuilder<T>?>.has('renderer', builder));
  }
}

class _AdaptiveColorThemeState<T extends ColorThemeBase>
    extends WidgetBindingState<AdaptiveColorTheme<T>> {
  late T _theme = widget.adapter.adapt;
  T get theme => _theme;
  set theme(T value) {
    if (_theme != value) setState(() => _theme = value);
  }

  @override
  void didUpdateWidget(covariant AdaptiveColorTheme<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.adapter != oldWidget.adapter) theme = widget.adapter.adapt;
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    theme = widget.adapter.adapt;
  }

  @override
  Widget build(BuildContext context) => widget.child.colorTheme(theme);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<T>('theme', theme));
  }
}

class ColorThemeAdapter<T extends ColorThemeBase> {
  const ColorThemeAdapter({
    this.mode = ColorThemeMode.system,
    required this.dark,
    required this.light,
  });

  final ColorThemeMode mode;
  final T dark;
  final T light;

  T get adapt => mode.shouldDark ? dark : light;
}

/// Define how to apply color themes.
///
/// Similar to the `ThemeMode` defined in `package:flutter/material.dart`.
/// This enum is redefined here to avoid unnecessary import of
/// the `material` library.
enum ColorThemeMode {
  system,
  light,
  dark;

  bool get shouldDark {
    final mode = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return this == ColorThemeMode.system
        ? mode == Brightness.dark
        : this == ColorThemeMode.dark;
  }
}

class ColorThemeApply<T extends ColorThemeBase> extends StatelessWidget {
  const ColorThemeApply({super.key, required this.theme, required this.child});

  final T theme;
  final Widget child;

  @override
  Widget build(BuildContext context) => child.colorThemeAs(context, theme);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<T>('theme', theme));
  }
}

abstract class ColorThemeBase extends AreaColors {
  const ColorThemeBase.light({
    required super.foreground,
    required super.background,
    this.brightness = Brightness.light,
  });

  const ColorThemeBase.dark({
    required super.foreground,
    required super.background,
    this.brightness = Brightness.dark,
  });

  final Brightness brightness;
}
