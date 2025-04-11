import 'dart:async';

typedef Compiler<T> = T Function(T source);

typedef FutureCallback = Future<void> Function();
typedef FutureOrCallback = FutureOr<void> Function();
typedef ErrorCallback = void Function(Object? error, StackTrace? stackTrace);

/// Mark that a type can be multiplied by a double.
// ignore: one_member_abstracts interface define.
abstract interface class Scalable<T> {
  T scale(double times);
}
