import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:state_reuse/binding.dart';

import 'locale_data.dart';
import 'locale_id.dart';

extension WrapAdaptiveLocale on Widget {
  AdaptiveLocale<T> adaptiveLocale<T extends LocaleBase>(
    LocaleAdapter<T> adapter, {
    Key? key,
  }) => AdaptiveLocale(adapter: adapter, child: this);
}

class AdaptiveLocale<T extends LocaleBase> extends StatefulWidget {
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

class _AdaptiveLocaleState<T extends LocaleBase>
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

class LocaleAdapter<T extends LocaleBase> {
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
