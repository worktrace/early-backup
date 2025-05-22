extension NullableIterable<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) if (test(element)) return element;
    return null;
  }

  /// Usually used on dynamic types, when [whereType] is not convenient.
  T get firstNotNull => firstWhere((i) => i != null);
  T? get firstMaybeNotNull => firstWhereOrNull((i) => i != null);

  Iterable<T>? get nullIfEmpty => isEmpty ? null : this;
}

extension IterableConvertShortcut<T> on Iterable<T> {
  List<T> get list => toList();
  Set<T> get asSet => toSet();
}

extension ConstructMapEntries<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> get asMap => Map.fromEntries(this);
}

extension RemoveSingleWhere<T> on List<T> {
  T removeFirstWhere(bool Function(T element) test) {
    final index = indexWhere(test);
    if (index == -1) throw StateError('No element satisfies the test.');
    return removeAt(index);
  }

  T? maybeRemoveFirstWhere(bool Function(T element) test) {
    final index = indexWhere(test);
    if (index == -1) return null;
    return removeAt(index);
  }

  T removeLastWhere(bool Function(T element) test) {
    final index = lastIndexWhere(test);
    if (index == -1) throw StateError('No element satisfies the test.');
    return removeAt(index);
  }

  T? maybeRemoveLastWhere(bool Function(T element) test) {
    final index = lastIndexWhere(test);
    if (index == -1) return null;
    return removeAt(index);
  }
}
