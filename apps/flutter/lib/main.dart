import 'package:auto_stories/auto_stories.dart';
import 'package:flutter/widgets.dart';

import 'state.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return 'WorkTrace'
        .asText()
        .center()
        .adaptiveColorTheme(ColorTheme.adapter())
        .textDirection(TextDirection.ltr)
        .mediaAsView(context);
  }
}
