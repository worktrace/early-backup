import 'package:flutter/widgets.dart';

extension RectUtils on Rect {
  RRect get capsule {
    return RRect.fromRectAndRadius(this, Radius.circular(shortestSide / 2));
  }
}
