import 'theme.dart';

class SettingsBase {
  const SettingsBase({
    this.themeMode = ThemeMode.system,
  });

  final ThemeMode themeMode;
}
