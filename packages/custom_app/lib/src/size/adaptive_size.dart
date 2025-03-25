import 'package:flutter/widgets.dart';

class AdaptiveSize extends StatefulWidget {
  const AdaptiveSize({super.key, required this.child});

  final Widget child;

  @override
  State<AdaptiveSize> createState() => _AdaptiveSizeState();
}

class _AdaptiveSizeState extends State<AdaptiveSize> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
