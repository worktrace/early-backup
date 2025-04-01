import 'dart:math' as math;

import 'package:compat_utils/number.dart';
import 'package:flutter/widgets.dart';

extension SizeCalculate on Size {
  /// Equals width + height.
  /// A value longer than diagonal and easy to compute.
  /// This value is designed to simplify computation to improve performance.
  double get longerThanDiagonal => width + height;
  double get diagonal => math.sqrt(width.square + height.square);
}
