import 'package:flutter/widgets.dart';
import 'package:inherit/inherit.dart';
import 'package:state_reuse/state_reuse.dart';

import 'adapt_layout.dart';
import 'adaptive_data.dart';

class AdaptiveLayout extends StatefulWidget {
  const AdaptiveLayout({super.key, required this.child});

  final Widget child;

  @override
  State<AdaptiveLayout> createState() => _AdaptiveLayoutState();
}

class _AdaptiveLayoutState extends State<AdaptiveLayout> with AdaptSize {
  late final LayoutAdapter _adapter = initLayout();

  @override
  Widget render(BuildContext context) {
    return widget.child.inherit(_adapter);
  }
}
