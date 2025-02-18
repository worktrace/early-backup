import 'package:avoid_nullable/avoid_nullable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_ui/src/effect.dart';
import 'package:smooth_ui/src/utils.dart';
import 'package:wrap/wrap.dart';

class SidebarContainer extends StatefulWidget {
  const SidebarContainer({
    super.key,
    this.colors = const SidebarColors(),
    this.size = const SidebarSize(),
    this.sidebarWidth = 256,
    this.primary = true,
    required this.sidebar,
    required this.child,
  });

  final SidebarColors colors;
  final SidebarSize size;
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
      ..add(DiagnosticsProperty<SidebarColors>('colors', colors))
      ..add(DiagnosticsProperty<SidebarSize>('size', size))
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

class SidebarColors extends RippleCardColors {
  const SidebarColors({
    super.background,
    super.foreground,
    super.border,
    super.shadow,
    super.ripple,
    this.resize = kRippleColor,
  });

  factory SidebarColors.lerp(SidebarColors a, SidebarColors b, double t) {
    return SidebarColors(
      background: lerpColor(a.background, b.background, t),
      foreground: Color.lerp(a.foreground, b.foreground, t),
      border: lerpColor(a.border, b.border, t),
      shadow: lerpColor(a.shadow, b.shadow, t),
      resize: lerpColor(a.resize, b.resize, t),
      ripple: AreaColors.lerp(a.ripple, b.ripple, t),
    );
  }

  final Color resize;
}

class SidebarSize extends CardSize {
  const SidebarSize({
    this.padding = const EdgeInsetsDirectional.only(
      top: 16,
      start: 16,
      bottom: 16,
    ),
    super.strokeAlign,
    super.border,
    super.shadow,
    this.sidebarMinWidth = 160,
    this.contentMinWidth = 185,
    this.resizeWidth = 6,
    this.resizePadding = const EdgeInsetsDirectional.only(
      top: 2,
      start: 4,
      bottom: 2,
    ),
  }) : assert(resizeWidth > 0);

  factory SidebarSize.lerp(SidebarSize a, SidebarSize b, double t) {
    return SidebarSize(
      padding: lerpEdgeInsetsDirectional(a.padding, b.padding, t),
      strokeAlign: lerpDouble(a.strokeAlign, b.strokeAlign, t),
      border: BorderSize.lerp(a.border, b.border, t),
      shadow: BoxShadowSize.lerp(a.shadow, b.shadow, t),
      sidebarMinWidth: lerpDouble(a.sidebarMinWidth, b.sidebarMinWidth, t),
      contentMinWidth: lerpDouble(a.contentMinWidth, b.contentMinWidth, t),
      resizeWidth: lerpDouble(a.resizeWidth, b.resizeWidth, t),
      resizePadding: lerpEdgeInsetsDirectional(
        a.resizePadding,
        b.resizePadding,
        t,
      ),
    );
  }

  final EdgeInsetsDirectional padding;
  final double sidebarMinWidth;
  final double contentMinWidth;
  final double resizeWidth;
  final EdgeInsetsDirectional resizePadding;
}
