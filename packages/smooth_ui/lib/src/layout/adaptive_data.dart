import 'package:flutter/rendering.dart';

class LayoutMode {
  const LayoutMode({
    this.window = WindowMode.landscape,
    this.fontSize = kFontSize,
  });

  factory LayoutMode.from(LayoutAdapter adapter, Size size) {
    return LayoutMode(
      window: WindowMode.from(adapter, size),
      fontSize: adapter.fontSize,
    );
  }

  final WindowMode window;
  final double fontSize;
}

class LayoutAdapter {
  const LayoutAdapter({
    this.landscapeWidth = 1000,
    this.portraitWidth = 600,
    this.fontSize = kFontSize,
  });

  final double landscapeWidth;
  final double portraitWidth;
  final double fontSize;
}

/// Default font size for default platform.
const double kFontSize = 15;

enum WindowMode {
  landscape,
  medium,
  portrait;

  static WindowMode from(LayoutAdapter adapter, Size size) {
    if (size.width >= adapter.landscapeWidth) return WindowMode.landscape;
    if (size.width >= adapter.portraitWidth) return WindowMode.medium;
    return WindowMode.portrait;
  }
}
