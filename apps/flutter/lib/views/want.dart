import 'package:auto_stories/kit.dart';
import 'package:go_router/go_router.dart';
import 'package:worktrace/state.dart';

final wantRoute = GoRoute(
  path: '/want',
  builder: (context, state) {
    final theme = context.find<Theme>()!;
    return SidebarContainer(
      colors: theme.sidebar,
      sidebar: 'sidebar'.asText().center(),
      child: 'create want'.asText().center(),
    );
  },
);

GoRoute exampleRoute() {
  return GoRoute(
    path: '/example',
    builder: (context, state) {
      final theme = context.find<Theme>()!;
      return SidebarContainer(
        colors: theme.sidebar,
        sidebar: 'sidebar'.asText().center(),
        child: 'example'.asText().center(),
      );
    },
  );
}
