import 'package:data_build/annotation.dart';
import 'package:flutter/widgets.dart';
import 'package:state_reuse/binding.dart';
import 'package:state_reuse/interact.dart';

part 'hover_follow.data.g.dart';

/// Enable hover follow effect onto this widget.
///
/// This widget must be a descendant of [HoverFollowArea] to enable the effect.
/// Current widget itself will only get the position and size to hover,
/// passing the state to the [HoverFollowArea] to ancestor to render the effect.
/// The exact effect is not rendered inside this widget exactly.
class HoverFollow extends HoverDefibrillation {
  const HoverFollow({
    super.key,
    super.defibrillation,
    super.onEnter,
    super.onExit,
    super.onHover,
    super.cursor,
    super.hitTestBehavior,
    super.opaque,
    super.child,
  });

  @override
  State<HoverFollow> createState() => _HoverFollowState();
}

class _HoverFollowState extends State<HoverFollow>
    with HoverDefibrillationMixin {
  @override
  Duration get defibrillation => widget.defibrillation;

  @override
  Widget? render(BuildContext context) => widget.child;
}

/// Display the hover follow effect in this area.
///
/// Wrap corresponding widgets with [HoverFollow] to enable the effect
/// onto that widget when hover, move or exit.
class HoverFollowArea extends StatefulWidget {
  const HoverFollowArea({super.key, required this.child});

  final Widget child;

  @override
  State<HoverFollowArea> createState() => _HoverFollowAreaState();
}

class _HoverFollowAreaState extends State<HoverFollowArea> {
  void _updateHoverRect(Rect rect) {}

  @override
  Widget build(BuildContext context) {
    return widget.child.inheritUpdate(_updateHoverRect);
  }
}

@equals
class HoverFollowPainter extends CustomPainter {
  const HoverFollowPainter({
    required this.rect,
    this.radius = BorderRadius.zero,
  });

  final Rect rect;
  final BorderRadius radius;

  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(covariant HoverFollowPainter oldDelegate) {
    return _$equals$HoverFollowPainter(this, oldDelegate);
  }
}
