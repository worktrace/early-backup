/// @docImport 'package:analyzer/dart/element/element.dart';
/// @docImport 'package:meta/meta_meta.dart';
library;

/// Throw when the annotation position is invalid.
///
/// The valid position of an annotation should be indicated by the [Target]
/// annotation provided by `package:meta`.
/// And it is supposed to be check before using the parsed [Element]
/// and assert the type of the source element.
class AnnotationPositionException<T> implements Exception {
  const AnnotationPositionException();

  @override
  String toString() => 'invalid annotation position of $T';
}
