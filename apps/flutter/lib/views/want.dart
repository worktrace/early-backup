import 'package:auto_stories/kit.dart';
import 'package:go_router/go_router.dart';
import 'package:worktrace/state.dart';

import 'sidebar.dart';

final wantRoute = GoRoute(
  path: '/want',
  builder: (context, state) {
    final theme = context.find<Theme>()!;
    return SidebarContainer(
      colors: theme.sidebar,
      sidebar: const Sidebar(),
      child: 'create want'.asText().center(),
    );
  },
);
