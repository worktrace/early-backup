import 'package:auto_stories/kit.dart';
import 'package:go_router/go_router.dart';
import 'package:worktrace/state.dart';

final loadingRoute = GoRoute(
  path: '/',
  builder: (context, state) {
    final locale = context.find<Locale>()!;
    return '${locale.loading}...'.asText().center();
  },
);
