import 'package:avoid_nullable/avoid_nullable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:inherit/inherit.dart';
import 'package:smooth_ui/utils.dart';
import 'package:state_reuse/state_reuse.dart';
import 'package:wrap/wrap.dart';

const themeAnimation = AnimationData(duration: Duration(milliseconds: 345));

extension WrapTheme on Widget {
  Widget themeAs<T extends ThemeBase>(BuildContext context, T theme) {
    return inherit(theme)
        .inherit(theme.brightness)
        .background(theme.background)
        .maybeForegroundAs(context, theme.foreground);
  }

  ThemeApply<T> theme<T extends ThemeBase>(T theme, {Key? key}) {
    return ThemeApply(key: key, theme: theme, child: this);
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

  Widget maybeAnimatedTheme<T extends ThemeBase>(
    T theme, {
    Key? key,
    Lerp<T>? lerp,
    AnimationData animation = const AnimationData(),
  }) {
    return lerp != null
        ? animatedTheme<T>(theme, lerp, key: key, animation: animation)
        : this.theme(theme, key: key);
  }

  AdaptiveTheme<T> adaptiveAnimatedTheme<T extends ThemeBase>(
    ThemeAdapter<T> adapter,
    Lerp<T> lerp, {
    Key? key,
    AnimationData animation = themeAnimation,
  }) {
    return AdaptiveTheme<T>(
      key: key,
      adapter: adapter,
      builder: (_, t) => animatedTheme<T>(t, lerp, animation: animation),
      child: this,
    );
  }

  AdaptiveTheme<T> adaptiveMaybeAnimatedTheme<T extends ThemeBase>(
    ThemeAdapter<T> adapter, {
    Key? key,
    Lerp<T>? lerp,
    AnimationData animation = themeAnimation,
  }) {
    if (lerp == null) return adaptiveTheme<T>(adapter, key: key);
    return adaptiveAnimatedTheme<T>(
      adapter,
      lerp,
      key: key,
      animation: animation,
    );
  }
}

typedef AdaptiveTheme<T extends ThemeBase> = _AdaptiveTheme<T, DataBuilder<T>>;

class _AdaptiveTheme<T extends ThemeBase, U extends DataBuilder<T>>
    extends StatefulWidget {
  const _AdaptiveTheme({
    super.key,
    required this.adapter,
    required this.builder,
    required this.child,
  });

  final ThemeAdapter<T> adapter;
  final U builder;
  final Widget child;

  @override
  State<_AdaptiveTheme<T, U>> createState() => _AdaptiveThemeState<T, U>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ThemeAdapter<T>>('adapter', adapter))
      ..add(ObjectFlagProperty<DataBuilder<T>?>.has('renderer', builder));
  }
}

class _AdaptiveThemeState<T extends ThemeBase, U extends DataBuilder<T>>
    extends WidgetBindingState<_AdaptiveTheme<T, U>> {
  late T _theme = widget.adapter.adapt;
  T get theme => _theme;
  set theme(T value) {
    if (_theme != value) setState(() => _theme = value);
  }

  @override
  void didUpdateWidget(covariant _AdaptiveTheme<T, U> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.adapter != oldWidget.adapter) theme = widget.adapter.adapt;
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    theme = widget.adapter.adapt;
  }

  @override
  Widget build(BuildContext context) => widget.child.themeAs(context, theme);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<T>('theme', theme));
  }
}

class ThemeAdapter<T extends ThemeBase> extends ThemeTween<T> {
  const ThemeAdapter({
    this.mode = ThemeMode.system,
    required super.dark,
    required super.light,
  });

  factory ThemeAdapter.from(ThemeTween<T> tween, ThemeMode mode) {
    return ThemeAdapter<T>(mode: mode, dark: tween.dark, light: tween.light);
  }

  final ThemeMode mode;

  T get adapt => mode.shouldDark ? dark : light;
}

class ThemeTween<T extends ThemeBase> {
  const ThemeTween({required this.dark, required this.light});

  final T dark;
  final T light;
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
