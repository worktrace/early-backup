class Range {
  const Range(
    this.defaultValue, {
    this.min = double.negativeInfinity,
    this.max = double.infinity,
  });

  final double min;
  final double max;
  final double defaultValue;
}
