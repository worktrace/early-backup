import 'package:auto_stories/kit.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final welcomeRoute = GoRoute(
  path: '/welcome',
  pageBuilder: (context, state) {
    return CustomTransitionPage(
      child: 'welcome'.asText().center(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  },
);
