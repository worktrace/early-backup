import 'package:custom_app/colors.dart';
import 'package:custom_app/locale.dart';

class SettingsBase {
  const SettingsBase({
    this.themeMode = ColorsMode.system,
    this.locales = const [],
  });

  final ColorsMode themeMode;
  final List<LocaleID> locales;
}
