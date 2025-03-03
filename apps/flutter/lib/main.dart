import 'package:auto_stories/kit.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'state.dart';
import 'views.dart';

void main() {
  runApp(const AppRoot());
}

/// A root widget to enable hot reload in Flutter.
///
/// Without such root widget, the output application will also work normally,
/// but the hot reload functionality to improve development experience
/// might not work as expected.
class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  ShellRoute layout(BuildContext context) {
    return ShellRoute(
      routes: [wantRoute, graphRoute],
      builder: (context, state, child) {
        final theme = context.find<Theme>()!;
        return SidebarContainer(
          colors: theme.sidebar,
          sidebar: 'sidebar'.asText().center(),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final routes = GoRouter(
      initialLocation: loadingRoute.path,
      routes: [loadingRoute, layout(context)],
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
