import 'package:auto_stories/kit.dart';
import 'package:go_router/go_router.dart';
import 'package:worktrace/state.dart';

final welcomeRoute = GoRoute(
  path: '/welcome',
  builder: (context, state) {
    final theme = context.find<Theme>()!;
    return SidebarContainer(
      colors: theme.sidebar,
      sidebar: 'sidebar'.asText().center(),
      child: 'content'.asText().center(),
    );
  },
);
