/// @docImport 'package:analyzer/dart/element/element.dart';
/// @docImport 'package:meta/meta_meta.dart';
library;

import 'annotation_generator.dart';
import 'composed_generator.dart';
import 'generate_annotation.dart';

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

class AnnotationsBuilder extends RecursiveAnnotationGenerator {
  const AnnotationsBuilder(this.generators, {super.throwOnUnresolved});

  @override
  final Iterable<GenerateFromAnnotation<dynamic>> generators;
}

class PartAnnotationsBuilder extends AnnotationsBuilder with PartGenerator {
  const PartAnnotationsBuilder(super.generators, {super.throwOnUnresolved});
}
