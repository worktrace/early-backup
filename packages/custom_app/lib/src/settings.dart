import 'locale.dart';
import 'theme.dart';

class SettingsBase {
  const SettingsBase({
    this.themeMode = ThemeMode.system,
    this.locales = const [],
  });

  final ThemeMode themeMode;
  final List<LocaleID> locales;
}
