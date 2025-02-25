import 'package:auto_stories/kit.dart';
import 'package:go_router/go_router.dart';

import 'sidebar.dart';

final wantRoute = GoRoute(
  path: '/want',
  builder: (context, state) {
    return SidebarContainer(
      sidebar: const Sidebar(),
      child: 'create want'.asText().center(),
    );
  },
);
