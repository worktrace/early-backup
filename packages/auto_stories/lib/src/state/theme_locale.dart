import 'package:auto_stories/src/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'binding.dart';

extension WrapLocale on Widget {
  LocaleApply<T> locale<T extends LocaleThemeBase>(T locale, {Key? key}) {
    return LocaleApply(
      key: key,
      locale: locale,
      child: this,
    );
  }

  // ignore: unnecessary_this readability.
  Inherit<T> localeAs<T extends LocaleThemeBase>(T locale) => this
      .textDirection(locale.direction) //
      .inherit(locale);

  AdaptiveLocale<T> adaptiveLocale<T extends LocaleThemeBase>(
    LocaleAdapter<T> adapter, {
    Key? key,
  }) {
    return AdaptiveLocale(
      adapter: adapter,
      child: this,
    );
  }
}

class AdaptiveLocale<T extends LocaleThemeBase> extends StatefulWidget {
  const AdaptiveLocale({super.key, required this.adapter, required this.child});

  final LocaleAdapter<T> adapter;
  final Widget child;

  @override
  State<AdaptiveLocale<T>> createState() => _AdaptiveLocaleState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<LocaleAdapter<T>>('adapter', adapter));
  }
}

class _AdaptiveLocaleState<T extends LocaleThemeBase>
    extends WidgetBindingState<AdaptiveLocale<T>> {
  late T _locale = widget.adapter.adapt;
  T get locale => _locale;
  set locale(T value) {
    if (value != _locale) setState(() => _locale = value);
  }

  @override
  void didUpdateWidget(covariant AdaptiveLocale<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.adapter != oldWidget.adapter) locale = widget.adapter.adapt;
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    if (widget.adapter.settings.isEmpty) locale = widget.adapter.adapt;
  }

  @override
  Widget build(BuildContext context) => widget.child.localeAs(locale);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<T>('locale', locale));
  }
}

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

class LocaleApply<T extends LocaleThemeBase> extends StatelessWidget {
  const LocaleApply({super.key, required this.locale, required this.child});

  final T locale;
  final Widget child;

  @override
  Widget build(BuildContext context) => child.localeAs(locale);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<T>('locale', locale));
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
