import 'dart:async';

typedef FutureCallback = Future<void> Function();
typedef FutureOrCallback = FutureOr<void> Function();
typedef ErrorCallback = void Function(Object? error, StackTrace? stackTrace);
