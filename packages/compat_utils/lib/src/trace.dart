import 'format.dart';
import 'terminal_wrap.dart';

enum TraceLevel {
  trace,
  debug,
  info,
  warn,
  error;

  // Override operators.
  bool operator >(TraceLevel other) => index > other.index;
  bool operator <(TraceLevel other) => index < other.index;
  bool operator >=(TraceLevel other) => index >= other.index;
  bool operator <=(TraceLevel other) => index <= other.index;

  /// The max length of all value names.
  ///
  /// 1. `static final` value rather than getter to improve performance.
  /// 2. It is useful when indenting the log output.
  /// 3. Attention that this is the exact length, extra spaces might required.
  static final int width = TraceLevel.values
      .map((value) => value.name.length)
      .reduce((a, b) => a > b ? a : b);

  String decorate({int? pad}) {
    final content = pad == null ? name : name.padLeft(pad);
    switch (this) {
      case trace:
        return content.magenta.italic;
      case debug:
        return content.blue.italic;
      case info:
        return content.green.italic;
      case warn:
        return content.yellow.italic;
      case error:
        return content.red.italic;
    }
  }
}

TracePosition? tracePosition({int depth = 2}) {
  final lines = StackTrace.current
      .toString()
      .split('\n')
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .toList();

  if (lines.length <= depth) return null;
  final message = RegExp(r'\(([^)]+)\)$')
      .firstMatch(lines[depth]) // Corresponding line according to depth.
      ?.group(1)
      ?.unwrapParenthesis
      .trim();

  if (message == null) return null;
  final index = RegExp(r':\d+:\d+$').firstMatch(message)?.start;

  if (index == null) return null;
  final path = message.substring(0, index);
  final position = message.substring(index + 1);

  if (path.isEmpty || position.isEmpty) return null;
  final splitIndex = position.indexOf(':');
  return TracePosition(
    path: path,
    line: int.parse(position.substring(0, splitIndex)),
    column: int.parse(position.substring(splitIndex + 1)),
  );
}

class TracePosition {
  const TracePosition({required this.path, this.line = 0, this.column = 0})
      : assert(line >= 0, column >= 0);

  final String path;
  final int line;
  final int column;

  @override
  String toString() => '$path:$line:$column';
}
