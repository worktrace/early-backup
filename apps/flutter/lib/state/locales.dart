import 'package:auto_stories/auto_stories.dart';
import 'package:flutter/widgets.dart';

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

LocaleAdapter<LocaleTheme> localesOf(List<LocaleID> settings) {
  return LocaleAdapter<LocaleTheme>(
    settings: settings,
    locales: buildInLocales,
    defaultLocale: zhHansCN,
  );
}

const List<LocaleTheme> buildInLocales = [
  enGB,
  enUS,
  zhHansCN,
  zhHantHK,
  zhHansSG,
];
