import 'package:auto_stories/auto_stories.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'state.dart';
import 'views.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = GoRouter(
      initialLocation: welcomeRoute.path,
      routes: [welcomeRoute],
    );

    return Router(
      routerDelegate: routes.routerDelegate,
      routeInformationParser: routes.routeInformationParser,
      routeInformationProvider: routes.routeInformationProvider,
      backButtonDispatcher: routes.backButtonDispatcher,
    )
        .adaptiveAnimatedTheme(Theme.adapter(), Theme.lerp)
        .adaptiveLocale(localesOf([]))
        .mediaAsView(context);
  }
}
