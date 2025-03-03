import 'package:auto_stories/kit.dart';
import 'package:go_router/go_router.dart';

GoRoute get wantRoute {
  return GoRoute(
    path: '/want',
    builder: (context, state) {
      return 'want'.asText().center();
    },
  );
}
