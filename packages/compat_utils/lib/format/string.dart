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

extension StringUtils on String {
  String get unwrapParenthesis => removePrefix('(').removeSuffix(')');

  String get firstCharacter => isNotEmpty ? this[0] : '';
  String get firstCharacterLower => firstCharacter.toLowerCase();
}

extension StringBufferUtils on StringBuffer {
  /// When not empty, add a space, to split between the following contents.
  void get adaptSpace {
    if (isNotEmpty) write(' ');
  }
}
