import 'package:auto_stories/auto_stories.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => 'WorkTrace'
      .asText()
      .center()
      .textDirection(TextDirection.ltr)
      .mediaAsView(context);
}
