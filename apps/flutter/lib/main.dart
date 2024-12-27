import 'package:auto_stories/auto_stories.dart';
import 'package:flutter/widgets.dart';

import 'state.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => const AppRoot()
      .adaptiveColorTheme(ColorTheme.adapter())
      .adaptiveLocale(localesOf([]))
      .mediaAsView(context);
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.find<LocaleTheme>()!;
    return locale.worktrace.asText().center();
  }
}
