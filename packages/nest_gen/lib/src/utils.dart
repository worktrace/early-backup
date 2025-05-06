class AnnotationPositionException<T> implements Exception {
  const AnnotationPositionException();

  @override
  String toString() => 'invalid annotation position of $T';
}
