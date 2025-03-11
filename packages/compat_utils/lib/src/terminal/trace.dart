import 'dart:io';

import 'package:compat_utils/compat_utils.dart';
import 'package:path/path.dart';

import 'terminal_wrap.dart';

/// Global [Trace] instance as modifiable variable.
// ignore: omit_obvious_property_types public api lint conflict.
Trace trace = const Trace();

/// A simple but configurable logger for tracing the program.
class Trace {
  const Trace({
    this.level = TraceLevel.trace,
    this.decorate = true,
    this.date = true,
    this.time = true,
    this.milliseconds = true,
    this.microseconds = false,
    this.timezone = false,
    this.levelName = true,
    this.longPath = true,
    this.traceErr = true,
    this.file = false,
    this.line = true,
    this.column = false,
  });

  final TraceLevel level;
  final bool decorate;
  final bool date;
  final bool time;
  final bool milliseconds;
  final bool microseconds;
  final bool timezone;
  final bool levelName;
  final bool longPath;
  final bool traceErr;
  final bool file;
  final bool line;
  final bool column;

  /// Write a log message.
  void write(String message, {required TraceLevel level}) {
    if (this.level > level) return;
    final buffer = StringBuffer();

    // Date and time.
    if (date || time) {
      final now = DateTime.now();
      final format = StringBuffer(date ? now.formatDate : '');
      if (time) {
        (format..adaptSpace).write(now.formatTime);
        if (milliseconds) format.write('.${now.millisecond.pad3}');
        if (microseconds) format.write('.${now.microsecond.pad3}');
        if (timezone) format.write(' ${now.formatTimezone}');
      }
      buffer.write(decorate ? format.toString().dim : format.toString());
    }

    // Level name.
    if (levelName) {
      final content =
          decorate
              ? level.decorate(pad: TraceLevel.width)
              : level.name.padLeft(TraceLevel.width);
      (buffer..adaptSpace).write(content);
    }

    // Code trace.
    if (file || (traceErr && level >= TraceLevel.warn)) {
      final position = tracePosition(depth: 3);
      if (position != null) {
        // File path.
        buffer.adaptSpace;
        if (longPath) {
          final dir = '${dirname(position.path)}$separator';
          buffer.write(decorate ? dir.dim : dir);
        }
        buffer.write(basenameWithoutExtension(position.path));
        final ext = extension(position.path);
        buffer.write(decorate ? ext.dim : ext);

        // Line and position
        final format = StringBuffer();
        if (line) format.write(':${position.line}');
        if (column) format.write(':${position.column}');
        buffer.write(decorate ? format.toString().dim : format.toString());
      }
    }

    (buffer..adaptSpace).write(message);
    stdout.writeln(buffer.toString());
  }

  // All loggers.
  void trace(String message) => write(message, level: TraceLevel.trace);
  void debug(String message) => write(message, level: TraceLevel.debug);
  void info(String message) => write(message, level: TraceLevel.info);
  void warn(String message) => write(message, level: TraceLevel.warn);
  void error(String message) => write(message, level: TraceLevel.error);
}

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
  final lines =
      StackTrace.current
          .toString()
          .split('\n')
          .map((line) => line.trim())
          .where((line) => line.isNotEmpty)
          .toList();

  if (lines.length <= depth) return null;
  final message =
      RegExp(r'\(([^)]+)\)$')
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
