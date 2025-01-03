import 'package:auto_stories/auto_stories.dart';
import 'package:go_router/go_router.dart';
import 'package:worktrace/state.dart';

final welcomeRoute = GoRoute(
  path: '/',
  builder: (context, state) {
    final locale = context.find<LocaleTheme>()!;
    return '${locale.loading}...'.asText().center();
  },
);
