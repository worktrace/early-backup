import 'package:build_data/annotation.dart';
import 'package:compat_utils/number.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_ui/effect.dart';
import 'package:smooth_ui/themes.dart';
import 'package:state_reuse/animation.dart';
import 'package:state_reuse/size.dart';
import 'package:wrap/annotation.dart';
import 'package:wrap/wrap.dart';

part 'sidebar.data.g.dart';
part 'sidebar.wrap.g.dart';

/// Default sidebar width as placeholder.
const double kSidebarWidth = 256;

class SidebarContainer extends StatefulWidget {
  @wrap
  const SidebarContainer({
    super.key,
    this.resizeAnimation = const AnimationDefibrillation(),
    this.resizeCursor = SystemMouseCursors.resizeColumn,
    this.colors = const SidebarColors(),
    this.size = const SidebarSize(),
    this.sidebarWidth = kSidebarWidth,
    this.primary = true,
    required this.sidebar,
    required this.child,
  });

  final AnimationDefibrillation resizeAnimation;
  final MouseCursor resizeCursor;

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
    final r = resizeAnimation;
    properties
      ..add(DiagnosticsProperty<AnimationDefibrillation>('resizeAnimation', r))
      ..add(DiagnosticsProperty<MouseCursor>('resizeCursor', resizeCursor))
      ..add(DiagnosticsProperty<SidebarColors>('colors', colors))
      ..add(DiagnosticsProperty<SidebarSize>('size', size))
      ..add(DoubleProperty('sidebarWidth', sidebarWidth))
      ..add(DiagnosticsProperty<bool>('primary', primary));
  }
}

class _SidebarContainerState extends State<SidebarContainer> with AdaptSize {
  late double _sidebarWidth = widget.sidebarWidth;

  var _resizeHover = false;
  var _resizing = false;

  double _delta = 0;

  double _computeSide(Offset localPosition) {
    final ltr = Directionality.of(context) == TextDirection.ltr;
    final left = widget.primary == ltr;
    return left ? localPosition.dx : sizeOrZero.width - localPosition.dx;
  }

  var _tapOnResizeBar = false;

  void _tapDown(TapDownDetails details) {
    if (_resizeHover) {
      _delta = _sidebarWidth - _computeSide(details.localPosition);
      _tapOnResizeBar = true;
    }
  }

  void _horizontalDragStart(DragStartDetails details) {
    if (_tapOnResizeBar) setState(() => _resizing = true);
  }

  void _horizontalDragUpdate(DragUpdateDetails details) {
    if (_resizing) {
      final width = _computeSide(details.localPosition) + _delta;
      final size = widget.size;
      final resolved = width.limit(
        min: size.sidebarMinWidth,
        max: this.size!.width - size.contentMinWidth,
      );
      setState(() => _sidebarWidth = resolved);
    }
  }

  void _horizontalDragEnd(DragEndDetails details) {
    _delta = 0;
    _tapOnResizeBar = false;
    setState(() => _resizing = false);
  }

  Widget sidebar(BuildContext context, {bool left = true}) {
    final colors = widget.colors;
    final size = widget.size;
    final mockDirection = left ? TextDirection.ltr : TextDirection.rtl;

    final resize = null
        .rippleLine(
          animation: widget.resizeAnimation,
          hold: _resizing,
          onEnter: (event) => setState(() => _resizeHover = true),
          onExit: (event) => setState(() => _resizeHover = false),
          opaque: false,
          color: colors.resize,
          padding: size.resizePadding.resolve(mockDirection),
        )
        .position(
          top: 0,
          left: left ? null : 0,
          right: left ? 0 : null,
          bottom: 0,
          width: size.resizeWidth,
        );

    return [widget.sidebar, resize]
        .asStack(clipBehavior: Clip.antiAlias)
        .background(colors.background)
        .maybeForegroundAs(context, colors.foreground);
  }

  @override
  Widget render(BuildContext context) {
    final realDirection = Directionality.of(context);
    final left = (realDirection == TextDirection.ltr) == widget.primary;

    final sidebar = this
        .sidebar(context, left: left)
        .position(
          top: 0,
          left: left ? 0 : null,
          right: left ? null : 0,
          bottom: 0,
          width: _sidebarWidth,
        );

    final content = widget.child.positionFill(
      left: left ? _sidebarWidth : 0,
      right: left ? 0 : _sidebarWidth,
    );

    final showResize = _resizeHover || _resizing;
    return [content, sidebar]
        .asStack(clipBehavior: Clip.antiAlias)
        .mouse(cursor: showResize ? widget.resizeCursor : MouseCursor.defer)
        .gesture(
          onHorizontalDragStart: _horizontalDragStart,
          onHorizontalDragUpdate: _horizontalDragUpdate,
          onHorizontalDragEnd: _horizontalDragEnd,
          onTapDown: _tapDown,
          onTapUp: (details) => _tapOnResizeBar = false,
        );
  }
}

class SidebarColors extends RippleCardColors with _$Copy$SidebarColors {
  @copy
  @lerp
  const SidebarColors({
    super.background,
    super.foreground,
    super.border,
    super.shadow,
    super.ripple,
    this.resize = kRippleColor,
  });

  factory SidebarColors.lerp(SidebarColors a, SidebarColors b, double t) {
    return _$lerp$SidebarColors(a, b, t);
  }

  final Color resize;
}

class SidebarSize extends CardSize with _$Copy$SidebarSize {
  @copy
  @lerp
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
    return _$lerp$SidebarSize(a, b, t);
  }

  final EdgeInsetsDirectional padding;
  final double sidebarMinWidth;
  final double contentMinWidth;
  final double resizeWidth;
  final EdgeInsetsDirectional resizePadding;
}
