import 'package:flutter/widgets.dart';

class SidebarContainer extends StatefulWidget {
  const SidebarContainer({
    super.key,
    required this.sidebar,
    required this.child,
  });

  final Widget sidebar;
  final Widget child;

  @override
  State<SidebarContainer> createState() => _SidebarContainerState();
}

class _SidebarContainerState extends State<SidebarContainer> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
