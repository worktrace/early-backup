import 'package:auto_stories/src/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

extension WrapTheme on Widget {
  Widget themeAs<T extends ThemeBase>(BuildContext context, T theme) {
    return inherit(theme)
        .inherit(theme.brightness)
        .background(theme.background)
        .maybeForegroundAs(context, theme.foreground);
  }

  ThemeApply<T> theme<T extends ThemeBase>(T theme, {Key? key}) {
    return ThemeApply(
      key: key,
      theme: theme,
      child: this,
    );
  }

  AdaptiveTheme<T> adaptiveTheme<T extends ThemeBase>(
    ThemeAdapter<T> adapter, {
    Key? key,
  }) {
    return AdaptiveTheme<T>(
      key: key,
      adapter: adapter,
      builder: themeAs<T>,
      child: this,
    );
  }

  SingleAnimation<T> animatedTheme<T extends ThemeBase>(
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
      builder: themeAs<T>,
    );
  }

  AdaptiveTheme<T> adaptiveAnimatedTheme<T extends ThemeBase>(
    ThemeAdapter<T> adapter,
    Lerp<T> lerp, {
    Key? key,
    AnimationData animation = const AnimationData(
      duration: Duration(milliseconds: 345),
    ),
  }) {
    return AdaptiveTheme<T>(
      key: key,
      adapter: adapter,
      builder: (_, t) => animatedTheme<T>(t, lerp, animation: animation),
      child: this,
    );
  }
}

typedef _DataBuilder<T> = Widget Function(BuildContext context, T data);

class AdaptiveTheme<T extends ThemeBase> extends StatefulWidget {
  const AdaptiveTheme({
    super.key,
    required this.adapter,
    required this.builder,
    required this.child,
  });

  final ThemeAdapter<T> adapter;
  final Widget Function(BuildContext context, T data) builder;
  final Widget child;

  @override
  State<AdaptiveTheme<T>> createState() => _AdaptiveThemeState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ThemeAdapter<T>>('adapter', adapter))
      ..add(ObjectFlagProperty<_DataBuilder<T>?>.has('renderer', builder));
  }
}

class _AdaptiveThemeState<T extends ThemeBase>
    extends WidgetBindingState<AdaptiveTheme<T>> {
  late T _theme = widget.adapter.adapt;
  T get theme => _theme;
  set theme(T value) {
    if (_theme != value) setState(() => _theme = value);
  }

  @override
  void didUpdateWidget(covariant AdaptiveTheme<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.adapter != oldWidget.adapter) theme = widget.adapter.adapt;
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    theme = widget.adapter.adapt;
  }

  @override
  Widget build(BuildContext context) => widget.child.theme(theme);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<T>('theme', theme));
  }
}

class ThemeAdapter<T extends ThemeBase> {
  const ThemeAdapter({
    this.mode = ThemeMode.system,
    required this.dark,
    required this.light,
  });

  final ThemeMode mode;
  final T dark;
  final T light;

  T get adapt => mode.shouldDark ? dark : light;
}

/// Define how to apply color themes.
///
/// Similar to the `ThemeMode` defined in `package:flutter/material.dart`.
/// This enum is redefined here to avoid unnecessary import of
/// the `material` library.
enum ThemeMode {
  system,
  light,
  dark;

  bool get shouldDark {
    final b = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return this == system ? b == Brightness.dark : this == dark;
  }
}

class ThemeApply<T extends ThemeBase> extends StatelessWidget {
  const ThemeApply({super.key, required this.theme, required this.child});

  final T theme;
  final Widget child;

  @override
  Widget build(BuildContext context) => child.themeAs(context, theme);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<T>('theme', theme));
  }
}

abstract class ThemeBase extends AreaColors {
  const ThemeBase.light({
    required super.foreground,
    required super.background,
    this.brightness = Brightness.light,
  });

  const ThemeBase.dark({
    required super.foreground,
    required super.background,
    this.brightness = Brightness.dark,
  });

  final Brightness brightness;
}
