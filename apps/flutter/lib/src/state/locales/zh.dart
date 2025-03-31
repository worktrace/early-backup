import 'package:auto_stories/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:worktrace/state.dart';

class ZhLocale extends Locale {
  const ZhLocale({
    super.name = '中文',
    super.id = const LocaleID('zh', scriptCode: 'hans'),
    super.direction = TextDirection.ltr,
    super.loading,
    super.worktrace,
  });
}

class ZhHantLocale extends ZhLocale {
  const ZhHantLocale({
    super.name = '中文 (繁體)',
    super.id = const LocaleID('zh', scriptCode: 'hant'),
    super.direction = TextDirection.ltr,
    super.loading = '載入中',
    super.worktrace,
  });
}

const zhHansCN = ZhLocale(
  name: '中文 (简体·中国)',
  id: LocaleID('zh', scriptCode: 'hans', areaCode: 'cn'),
);

const zhHantHK = ZhHantLocale(
  name: '中文 (繁體·中國香港)',
  id: LocaleID('zh', scriptCode: 'hant', areaCode: 'hk'),
);

const zhHansSG = ZhLocale(
  name: '中文 (简体·新加坡)',
  id: LocaleID('zh', scriptCode: 'hans', areaCode: 'sg'),
);
