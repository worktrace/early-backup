import 'package:flutter/widgets.dart';

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
