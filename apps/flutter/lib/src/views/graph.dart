import 'package:auto_stories/helpers.dart';
import 'package:go_router/go_router.dart';

GoRoute get graphRoute => GoRoute(
  path: '/graph',
  builder: (context, state) => 'graph'.asText().center(),
);
