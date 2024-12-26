import 'package:auto_stories/auto_stories.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adapt settings', () {
    expect(
      const LocaleAdapter(
        settings: [LocaleID('zh')],
        locales: [zhHansCN, zhHantHK],
        defaultLocale: zhHansCN,
      ).adapt,
      zhHansCN,
    );
    expect(
      const LocaleAdapter(
        settings: [LocaleID('zh', scriptCode: 'Hant')],
        locales: [zhHansCN, zhHantHK],
        defaultLocale: zhHansCN,
      ).adapt,
      zhHantHK,
    );
    expect(
      const LocaleAdapter(
        settings: [LocaleID('zh', areaCode: 'HK')],
        locales: [zhHansCN, zhHantHK],
        defaultLocale: zhHansCN,
      ).adapt,
      zhHantHK,
    );
  });
}

class LocaleTheme extends LocaleThemeBase {
  const LocaleTheme({
    required super.name,
    required super.id,
    super.direction = TextDirection.ltr,
  });
}

const zhHansCN = LocaleTheme(
  name: '中文(简体·中国)',
  id: LocaleID('zh', scriptCode: 'Hans', areaCode: 'CN'),
);

const zhHantHK = LocaleTheme(
  name: '中文(繁體·中國香港)',
  id: LocaleID('zh', scriptCode: 'Hant', areaCode: 'HK'),
);
