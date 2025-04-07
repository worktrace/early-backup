import 'package:auto_stories/helpers.dart';
import 'package:go_router/go_router.dart';

GoRoute get wantRoute => GoRoute(
  path: '/want',
  builder: (context, state) => 'want'.asText().center(),
);
