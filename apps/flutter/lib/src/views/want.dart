import 'package:auto_stories/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

GoRoute get wantRoute {
  return GoRoute(
    path: '/want',
    builder: (context, state) {
      final media = MediaQuery.of(context);
      return 'size: ${media.size}'.asText().center();
    },
  );
}
