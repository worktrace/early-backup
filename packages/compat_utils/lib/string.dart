extension PrefixAndSuffix on String {
  String removePrefix(String prefix) {
    return startsWith(prefix) ? substring(prefix.length) : this;
  }

  String removeSuffix(String suffix) {
    return endsWith(suffix) ? substring(0, length - suffix.length) : this;
  }

  String ensurePrefix(String prefix) {
    return startsWith(prefix) ? this : '$prefix$this';
  }

  String ensureSuffix(String suffix) {
    return endsWith(suffix) ? this : '$this$suffix';
  }

  String get unwrapParenthesis => removePrefix('(').removeSuffix(')');
}

extension StringBeforeAndAfter on String {
  String? before(String separator) {
    final index = indexOf(separator);
    if (index == -1) return null;
    return substring(0, index);
  }

  String? after(String separator) {
    final index = indexOf(separator);
    if (index == -1) return null;
    return substring(index + separator.length);
  }

  String beforeOrAll(String separator) => before(separator) ?? this;
  String afterOrAll(String separator) => after(separator) ?? this;
}

extension SplitString on String {
  (String, String)? splitOnce(String separator) {
    final index = indexOf(separator);
    if (index == -1) return null;
    return (substring(0, index), substring(index + separator.length));
  }

  (String, String)? splitLastOnce(String separator) {
    final index = lastIndexOf(separator);
    if (index == -1) return null;
    return (substring(0, index), substring(index + separator.length));
  }
}
