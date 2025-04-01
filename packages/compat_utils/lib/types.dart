import 'dart:async';

typedef Compiler<T> = T Function(T source);

typedef FutureCallback = Future<void> Function();
typedef FutureOrCallback = FutureOr<void> Function();
typedef ErrorCallback = void Function(Object? error, StackTrace? stackTrace);

/// Mark that a type can be multiplied by a double.
mixin Times<T> {
  T operator *(double times);
}

/// Mark that a type has `copyWith` method.
mixin Copy<T> {
  T copyWith();
}
