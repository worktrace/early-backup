import 'package:flutter/widgets.dart';

/// Enable hover follow effect onto this widget.
///
/// This widget must be a descendant of [HoverFollowArea] to enable the effect.
/// Current widget itself will only get the position and size to hover,
/// passing the state to the [HoverFollowArea] to ancestor to render the effect.
/// The exact effect is not rendered inside this widget exactly.
class HoverFollow extends StatefulWidget {
  const HoverFollow({super.key, required this.child});

  final Widget child;

  @override
  State<HoverFollow> createState() => _HoverFollowState();
}

class _HoverFollowState extends State<HoverFollow> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
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
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
