import 'package:auto_stories/auto_stories.dart';
import 'package:flutter/widgets.dart';
import 'package:worktrace/state/locales/ar.dart';

import 'build_in_locales.dart';

class LocaleTheme extends LocaleThemeBase {
  const LocaleTheme({
    required super.name,
    required super.id,
    super.direction = TextDirection.ltr,
    this.loading = '加载中',
    this.worktrace = '工作溯源',
  });

  final String loading;
  final String worktrace;
}

LocaleAdapter<LocaleTheme> localesOf(
  List<LocaleID> settings, {
  List<LocaleTheme> locales = buildInLocales,
  LocaleTheme defaultLocale = zhHansCN,
}) {
  return LocaleAdapter<LocaleTheme>(
    settings: settings,
    locales: locales,
    defaultLocale: defaultLocale,
  );
}

const List<LocaleTheme> buildInLocales = [
  arEG,
  enGB,
  enUS,
  zhHansCN,
  zhHantHK,
  zhHansSG,
];
