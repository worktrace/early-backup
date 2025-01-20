/// Computed value of golden ratio (sqrt(5) - 1) / 2.
const double goldenRatio = _goldenRatio;

// Avoid name conflict.
const _goldenRatio = 0.6180339887498949;

extension DoubleConvert on double {
  double get square => this * this;
  double get goldenRatio => this * _goldenRatio;
}
