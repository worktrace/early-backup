import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:state_reuse/binding.dart';
import 'package:wrap/wrap.dart';

import 'locale_id.dart';

extension WrapLocale on Widget {
  LocaleApply<T> locale<T extends LocaleBase>(T locale, {Key? key}) {
    return LocaleApply(key: key, locale: locale, child: this);
  }

  // ignore: unnecessary_this readability.
  Inherit<T> localeAs<T extends LocaleBase>(T locale) => this
      .textDirection(locale.direction) //
      .inherit(locale);
}

class LocaleApply<T extends LocaleBase> extends StatelessWidget {
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

abstract class LocaleBase {
  const LocaleBase({
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
