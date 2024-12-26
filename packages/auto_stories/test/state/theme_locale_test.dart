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

  testWidgets('adapt system', (t) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.platformDispatcher.localesTestValue = [];
    final probe = Builder(
      builder: (context) {
        return context.find<LocaleTheme>()!.id.toString().asText();
      },
    );
    const adapter = LocaleAdapter(
      locales: [enUS, zhHansSG],
      defaultLocale: zhHansCN,
    );
    await t.pumpWidget(probe.center().adaptiveLocale(adapter));
    expect(find.text(zhHansCN.id.toString()), findsOneWidget);

    binding.platformDispatcher.localesTestValue = [const Locale('en')];
    await t.pump();
    expect(find.text(enUS.id.toString()), findsOneWidget);

    // Use first matched value rather than default value (same language).
    binding.platformDispatcher.localesTestValue = [const Locale('zh')];
    await t.pump();
    expect(find.text(zhHansSG.id.toString()), findsOneWidget);

    // Won't use default value unless completely necessary.
    binding.platformDispatcher.localesTestValue = [const Locale('zh', 'CN')];
    await t.pump();
    expect(find.text(zhHansSG.id.toString()), findsOneWidget);
  });

  testWidgets('resolve null', (t) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.platformDispatcher.localesTestValue = [];
    final probe = Builder(
      builder: (context) {
        return context.find<LocaleTheme>()!.id.toString().asText();
      },
    );
    const adapter = LocaleAdapter(
      locales: [enUS, zhHansSG],
      defaultLocale: zhHantHK,
    );
    await t.pumpWidget(probe.center().adaptiveLocale(adapter));
    expect(find.text(zhHantHK.id.toString()), findsOneWidget);

    // Match first in the system locales.
    binding.platformDispatcher.localesTestValue = [
      const Locale('zh', 'CN'),
      const Locale('en'),
    ];
    await t.pump();
    expect(find.text(zhHansSG.id.toString()), findsOneWidget);

    // Match first in the system locales regardless of area code.
    binding.platformDispatcher.localesTestValue = [
      const Locale('zh'),
      const Locale('en', 'SG'),
    ];
    await t.pump();
    expect(find.text(zhHansSG.id.toString()), findsOneWidget);
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

const zhHansSG = LocaleTheme(
  name: '中文(简体·新加坡)',
  id: LocaleID('zh', scriptCode: 'Hans', areaCode: 'SG'),
);

const enUS = LocaleTheme(
  name: 'English (United States)',
  id: LocaleID('en', areaCode: 'US'),
);
