import 'package:auto_stories/src/utils.dart';
import 'package:flutter/widgets.dart';

extension WrapScale on Widget {
  Widget scaleFactor<T extends ScaleBasic>(T scale) {
    return inherit<T>(scale);
  }
}

abstract class ScaleBasic {
  const ScaleBasic({this.normal = 1});

  final double normal;
}
