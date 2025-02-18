import 'dart:math' as math;

/// Computed value of golden ratio (sqrt(5) - 1) / 2.
const double goldenRatio = _goldenRatio;

// Avoid name conflict.
const _goldenRatio = 0.6180339887498949;

extension DoubleConvert on double {
  double get square => this * this;
  double get goldenRatio => this * _goldenRatio;
}

extension LimitDouble on double {
  double limit({double? min, double? max}) {
    if (min == null) {
      return max == null ? this : math.min(this, max);
    } else if (max == null) {
      return math.max(this, min);
    } else {
      return math.min(math.max(this, min), max);
    }
  }
}
