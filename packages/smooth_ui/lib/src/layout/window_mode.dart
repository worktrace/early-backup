import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:inherit/inherit.dart';
import 'package:state_reuse/state_reuse.dart';

enum WindowMode {
  landscape,
  medium,
  portrait;

  const WindowMode();

  static WindowMode get asPlatform {
    if (kIsWeb) return WindowMode.landscape;
    return WindowMode.landscape;
  }
}

class WindowAdapter extends StatefulWidget {
  const WindowAdapter({super.key, required this.child});

  final Widget child;

  @override
  State<WindowAdapter> createState() => _WindowAdapterState();
}

class _WindowAdapterState extends State<WindowAdapter> with AdaptSize {
  late final WindowMode _mode = WindowMode.asPlatform;

  @override
  Widget render(BuildContext context) {
    return widget.child.inherit(_mode);
  }
}
