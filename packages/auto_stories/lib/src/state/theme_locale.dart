import 'package:flutter/widgets.dart';

class LocaleAdapter<T extends LocaleThemeBase> {
  const LocaleAdapter({
    this.settings = const [],
    this.locales = const [],
    required this.defaultLocale,
  });

  final List<LocaleID> settings;
  final List<T> locales;
  final T defaultLocale;

  T get adapt {
    final ids = settings.isEmpty ? LocaleID.platform : settings;
    var handler = defaultLocale;
    var matchLevel = LocaleMatch.none;
    for (final setting in ids) {
      for (final locale in locales) {
        final level = setting.compare(locale.id);
        if (level == LocaleMatch.all) return locale;
        if (level <= matchLevel) continue;
        matchLevel = level;
        handler = locale;
      }
    }
    return handler;
  }
}

abstract class LocaleThemeBase {
  const LocaleThemeBase({
    required this.name,
    required this.id,
    this.direction = TextDirection.ltr,
  });

  final String name;
  final LocaleID id;
  final TextDirection direction;

  @override
  String toString() => '$name($id)';
}

@immutable
class LocaleID {
  const LocaleID(this.languageCode, {this.scriptCode, this.areaCode});

  final String languageCode;
  final String? scriptCode;
  final String? areaCode;

  @override
  int get hashCode => Object.hash(languageCode, scriptCode, areaCode);

  @override
  bool operator ==(Object other) =>
      other is LocaleID &&
      other.languageCode == languageCode &&
      other.scriptCode == scriptCode &&
      other.areaCode == areaCode;

  @override
  String toString() {
    return [
      languageCode,
      if (scriptCode != null) scriptCode,
      if (areaCode != null) areaCode,
    ].join('-');
  }

  LocaleMatch compare(LocaleID another) {
    if (languageCode != another.languageCode) return LocaleMatch.none;
    final areaMatch = areaCode == another.areaCode && areaCode != null;
    return (scriptCode == another.scriptCode && scriptCode != null)
        ? (areaMatch ? LocaleMatch.all : LocaleMatch.script)
        : (areaMatch ? LocaleMatch.area : LocaleMatch.language);
  }

  static Iterable<LocaleID> get platform {
    return WidgetsBinding.instance.platformDispatcher.locales.map((locale) {
      return LocaleID(
        locale.languageCode,
        scriptCode: locale.scriptCode,
        areaCode: locale.countryCode,
      );
    });
  }
}

enum LocaleMatch {
  none,
  language,
  area,
  script,
  all;

  bool operator <(LocaleMatch other) => index < other.index;
  bool operator <=(LocaleMatch other) => index <= other.index;
  bool operator >(LocaleMatch other) => index > other.index;
  bool operator >=(LocaleMatch other) => index >= other.index;
}
