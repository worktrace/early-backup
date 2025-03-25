import 'package:flutter/widgets.dart';

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
  String toString() => [
    languageCode,
    if (scriptCode != null) scriptCode,
    if (areaCode != null) areaCode,
  ].join('-');

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
