import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:wrap/wrap.dart';

class SidebarContainer extends StatefulWidget {
  const SidebarContainer({
    super.key,
    this.sidebarWidth = 256,
    this.primary = true,
    required this.sidebar,
    required this.child,
  });

  final double sidebarWidth;

  /// Whether the sidebar is on the beginning side as text direction.
  ///
  /// For example: when current locale is LTR (from left to right),
  /// and [primary] is `true`, then the sidebar is on the left side,
  /// and when the [primary] is `false`, then the sidebar is on the right side.
  /// When current locale is LTR (from right to left) and [primary] is `false`,
  /// the sidebar will also be on the left side.
  final bool primary;

  final Widget sidebar;
  final Widget child;

  @override
  State<SidebarContainer> createState() => _SidebarContainerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('sidebarWidth', sidebarWidth))
      ..add(DiagnosticsProperty<bool>('primary', primary));
  }
}

class _SidebarContainerState extends State<SidebarContainer> {
  @override
  Widget build(BuildContext context) {
    final realDirection = Directionality.of(context);
    final left = (realDirection == TextDirection.ltr) == widget.primary;

    final sidebar = widget.sidebar.position(
      top: 0,
      left: left ? 0 : null,
      right: left ? null : 0,
      bottom: 0,
      width: widget.sidebarWidth,
    );

    final content = widget.child.positionFill(
      left: left ? widget.sidebarWidth : 0,
      right: left ? 0 : widget.sidebarWidth,
    );

    return [content, sidebar].asStack(clipBehavior: Clip.antiAlias);
  }
}
