import 'package:auto_stories/kit.dart';
import 'package:go_router/go_router.dart';
import 'package:worktrace/state.dart';

import 'welcome.dart';

final loadingRoute = GoRoute(
  path: '/',
  builder: (context, state) {
    final locale = context.find<Locale>()!;
    return LoadingContainer(
      onFinish: () => context.go(welcomeRoute.path),
      onError: (err, trace) {},
      child: '${locale.loading}...'.asText().center(),
    );
  },
);
