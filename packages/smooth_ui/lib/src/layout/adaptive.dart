import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:inherit/inherit.dart';

import 'adaptive_data.dart';
import 'adaptive_io.dart' if (kIsWeb) 'adaptive_web.dart';

class AdaptiveLayout extends StatefulWidget {
  const AdaptiveLayout({super.key, required this.child});

  final Widget child;

  @override
  State<AdaptiveLayout> createState() => _AdaptiveLayoutState();
}

class _AdaptiveLayoutState extends State<AdaptiveLayout> {
  late final AdaptedLayout _layout = adaptLayout();

  @override
  Widget build(BuildContext context) {
    return widget.child.inherit(_layout);
  }
}
