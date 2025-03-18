import 'package:flutter/widgets.dart';
import 'package:inherit/inherit.dart';

class AdaptiveLayout extends StatefulWidget {
  const AdaptiveLayout({super.key, required this.child});

  final Widget child;

  @override
  State<AdaptiveLayout> createState() => _AdaptiveLayoutState();
}

class _AdaptiveLayoutState extends State<AdaptiveLayout> {
  late final _layout = const AdaptedLayout();

  @override
  Widget build(BuildContext context) {
    return widget.child.inherit(_layout);
  }
}

class AdaptedLayout {
  const AdaptedLayout({this.mode = WindowMode.landscape});

  final WindowMode mode;
}

enum WindowMode { landscape, medium, portrait }
