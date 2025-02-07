extension StringUtils on String {
  String removePrefix(String prefix) {
    return startsWith(prefix) ? substring(prefix.length) : this;
  }

  String removeSuffix(String suffix) {
    return endsWith(suffix) ? substring(0, length - suffix.length) : this;
  }

  String get unwrapParenthesis => removePrefix('(').removeSuffix(')');

  (String, String)? splitOnce(String separator) {
    final index = indexOf(separator);
    if (index == -1) return null;
    return (substring(0, index), substring(index + separator.length));
  }
}

extension StringBufferUtils on StringBuffer {
  /// When not empty, add a space, to split between the following contents.
  void get adaptSpace {
    if (isNotEmpty) write(' ');
  }
}

extension FormatDateTime on DateTime {
  String get formatDate {
    final m = month.pad2;
    final d = day.pad2;
    return '$year.$m.$d(${weekday == 7 ? 0 : weekday})';
  }

  String get formatTime {
    final h = hour.pad2;
    final m = minute.pad2;
    final s = second.pad2;
    return '$h:$m:$s';
  }

  String get formatTimezone {
    if (isUtc) return 'utc';
    final offset = timeZoneOffset;
    final sign = offset.isNegative ? '-' : '+';
    final h = offset.inHours.abs().pad2;
    final m = (offset.inMinutes.abs() % Duration.minutesPerHour).pad2;
    return '$sign$h:$m';
  }
}

extension PadNumber on int {
  String get pad2 => toString().padLeft(2, '0');
  String get pad3 => toString().padLeft(3, '0');
}

extension CaseConvert on String {
  /// Split string into parts according to their case.
  ///
  /// 1. All result parts will be lowercased.
  /// 2. It will split by non-alphabet-and-digit characters,
  /// including whitespace and hyphen.
  /// 3. About the case change without separator, see [splitCamelCase].
  List<String> get parts => split(RegExp('[^a-zA-Z0-9]'))
      .map((part) => part.splitCamelCase)
      .expand((nestedPart) => nestedPart)
      .toList();

  /// Split camel case.
  ///
  /// All result parts will be lowercased.
  /// It will split when changing from lowercase to uppercase,
  /// and before from uppercase to lowercase. For example:
  ///
  /// 1. From `'ABCAndAnotherABC'` to `['abc', 'and', 'another', 'abc']`.
  /// 2. From `'abc123abc'` to `['abc123', 'abc']`.
  List<String> get splitCamelCase {
    if (isEmpty) return [];
    final handler = <String>[];
    var char = this[0];
    late String before;
    final buffer = StringBuffer(char);
    for (var i = 1; i < length; i++) {
      before = char;
      char = this[i];
      final current = buffer.toString();

      // From lowercase or digit to uppercase, or from digit to alphabet.
      if (current.isNotEmpty &&
          (((before._lower || before._digit) && char._upper) ||
              (before._digit && (char._upper || char._lower)))) {
        handler.add(current);
        buffer
          ..clear()
          ..write(char);
      }
      // Before uppercase to lowercase.
      else if (current.length > 1 && before._upper && char._lower) {
        handler.add(current.substring(0, current.length - 1));
        buffer
          ..clear()
          ..write(before)
          ..write(char);
      }
      // Otherwise, just pass.
      else {
        buffer.write(char);
      }
    }

    if (buffer.isNotEmpty) handler.add(buffer.toString());
    return handler.map((part) => part.toLowerCase()).toList();
  }

  // Only check the first char, it is supposed to be a char.
  bool get _upper => codeUpper(codeUnitAt(0));
  bool get _lower => codeLower(codeUnitAt(0));
  bool get _digit => codeDigit(codeUnitAt(0));

  bool codeUpper(int charCode) => charCode >= _upperA && charCode <= _upperZ;
  bool codeLower(int charCode) => charCode >= _lowerA && charCode <= _lowerZ;
  bool codeDigit(int charCode) => charCode >= _code0 && charCode <= _code9;

  static final int _upperA = 'a'.toUpperCase().codeUnitAt(0);
  static final int _upperZ = 'z'.toUpperCase().codeUnitAt(0);
  static final int _lowerA = 'a'.toLowerCase().codeUnitAt(0);
  static final int _lowerZ = 'z'.toLowerCase().codeUnitAt(0);
  static final int _code0 = '0'.codeUnitAt(0);
  static final int _code9 = '9'.codeUnitAt(0);

  /// Uppercase the first character and remain the rest.
  String get capitalCase => isEmpty ? '' : this[0].toUpperCase() + substring(1);
  String get upperCase => toUpperCase();
  String get lowerCase => toLowerCase();

  String get wordsCase => parts.join(' ');
  String get kebabCase => parts.join('-');
  String get snakeCase => parts.join('_');
  String get constCase => parts.map((raw) => raw.toUpperCase()).join('_');
  String get pascalCase => parts.map((raw) => raw.capitalCase).join();
  String get camelCase {
    if (isEmpty) return '';
    return parts[0] + parts.sublist(1).map((raw) => raw.capitalCase).join();
  }
}
