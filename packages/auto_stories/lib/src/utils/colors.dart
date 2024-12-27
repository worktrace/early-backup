import 'package:flutter/widgets.dart';

class AreaColors {
  const AreaColors({this.background = Colors.transparent, this.foreground});

  final Color background;
  final Color? foreground;
}

abstract class Colors {
  // Transparent colors.
  static const transparent = Color(0x00000000);
}
