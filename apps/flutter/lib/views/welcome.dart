import 'package:auto_stories/kit.dart';
import 'package:go_router/go_router.dart';

final welcomeRoute = GoRoute(
  path: '/welcome',
  builder: (context, state) {
    return SidebarContainer(
      sidebar: 'sidebar'.asText().center(),
      child: 'content'.asText().center(),
    );
  },
);
