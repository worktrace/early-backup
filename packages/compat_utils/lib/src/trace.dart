import 'format.dart';

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
