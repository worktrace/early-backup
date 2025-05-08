import 'package:auto_stories/annotation.dart';
import 'package:auto_stories/helpers.dart';
import 'package:flutter/widgets.dart' hide Locale;

import 'locales.dart';

part 'locale.data.g.dart';

class Locale extends LocaleBase {
  @copy
  const Locale({
    required super.name,
    required super.id,
    super.direction = TextDirection.ltr,
    this.loading = '加载中',
    this.worktrace = '工作溯源',
  });

  final String loading;
  final String worktrace;
}

LocaleAdapter<Locale> localesOf(
  List<LocaleID> settings, {
  List<Locale> locales = buildInLocales,
  Locale defaultLocale = zhHansCN,
}) => LocaleAdapter<Locale>(
  settings: settings,
  locales: locales,
  defaultLocale: defaultLocale,
);

const List<Locale> buildInLocales = [
  arEG,
  enGB,
  enUS,
  zhHansCN,
  zhHantHK,
  zhHansSG,
];
