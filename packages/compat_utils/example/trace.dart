import 'package:compat_utils/compat_utils.dart';

void main() => traceExample();

void traceExample() {
  trace = const Trace(column: true, timezone: true);
  trace
    ..trace('trace message')
    ..debug('debug message')
    ..info('info message')
    ..warn('warn message')
    ..error('error message');

  trace = const Trace(decorate: false, column: true, timezone: true);
  trace.trace('without decorate');

  trace = const Trace();
  trace.trace('default configurations');

  trace = const Trace(decorate: false, date: false, time: false);
  trace.trace('disable all');
}
