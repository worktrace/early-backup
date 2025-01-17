import 'package:flutter/widgets.dart';

mixin GraphElement {
  void paint(Canvas canvas);
}

class RectElement extends Rect with GraphElement {
  const RectElement({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  })  : assert(left <= right),
        assert(top <= bottom),
        super.fromLTRB(left, top, right, bottom);

  @override
  void paint(Canvas canvas) {}
}
