import 'package:auto_stories/kit.dart';
import 'package:flutter/widgets.dart';
import 'package:worktrace/state.dart';

class EnLocale extends ZhLocale {
  const EnLocale({
    super.name = 'English',
    super.id = const LocaleID('en'),
    super.direction = TextDirection.ltr,
    super.loading = 'Loading',
    super.worktrace = 'WorkTrace',
  });
}

const enGB = EnLocale(
  name: 'English (United Kingdom)',
  id: LocaleID('en', areaCode: 'gb'),
);

const enUS = EnLocale(
  name: 'English (United States)',
  id: LocaleID('en', areaCode: 'us'),
);
