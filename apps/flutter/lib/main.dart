import 'package:auto_stories/kit.dart';
import 'package:auto_stories/web.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'state.dart';
import 'views.dart';

void main() {
  usePathUrlStrategy();
  runApp(const AppRoot());
}

/// A root widget to enable hot reload in Flutter.
///
/// Without such root widget, the output application will also work normally,
/// but the hot reload functionality to improve development experience
/// might not work as expected.
class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  RouteBase layout(BuildContext context) {
    return ShellRoute(
      routes: [wantRoute, graphRoute],
      builder: (context, state, child) {
        final colors = context.find<Colors>()!;
        return SidebarContainer(
          colors: colors.sidebar,
          sidebar: 'sidebar'.asText().center(),
          child: child,
        );
      },
    );
  }

  RouterConfig<RouteMatchList> routes(BuildContext context) {
    final loading = loadingRoute();
    return GoRouter(
      initialLocation: loading.path,
      routes: [loading, layout(context)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Router.withConfig(config: routes(context))
        .adaptiveAnimatedColors(Colors.adapter(), Colors.lerp)
        .adaptiveLocale(localesOf([]))
        .mediaAsView(context);
  }
}
