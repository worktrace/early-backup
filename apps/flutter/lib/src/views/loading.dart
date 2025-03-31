import 'package:auto_stories/helpers.dart';
import 'package:go_router/go_router.dart';
import 'package:worktrace/state.dart';

import 'want.dart';

GoRoute loadingRoute() {
  return GoRoute(
    path: '/',
    builder: (context, state) {
      final locale = context.find<Locale>()!;
      return LoadingContainer(
        onFinish: () => context.go(wantRoute.path),
        onError: (err, trace) {},
        child: '${locale.loading}...'.asText().center(),
      );
    },
  );
}
