import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:inherit/inherit.dart';

import 'locale.dart';
import 'settings.dart';
import 'theme.dart';

class CustomApp<T extends ThemeBase, L extends LocaleBase,
    S extends SettingsBase> extends StatelessWidget {
  const CustomApp({
    super.key,
    required this.darkTheme,
    required this.lightTheme,
    required this.locale,
    required this.settings,
    required this.child,
  });

  final T darkTheme;
  final T lightTheme;
  final L locale;
  final S settings;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Handler(
      data: settings,
      builder: (context, settings) {
        return child;
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<T>('darkTheme', darkTheme))
      ..add(DiagnosticsProperty<T>('lightTheme', lightTheme))
      ..add(DiagnosticsProperty<L>('locale', locale))
      ..add(DiagnosticsProperty<S>('settings', settings));
  }
}
