/// @docImport 'package:analyzer/dart/element/element.dart';
/// @docImport 'package:meta/meta_meta.dart';
library;

import 'annotation_generator.dart';
import 'composed_generator.dart';
import 'generate_annotation.dart';

class AnnotationsBuilder extends RecursiveAnnotationGenerator {
  const AnnotationsBuilder(this.generators, {super.throwOnUnresolved});

  @override
  final Iterable<GenerateOnAnnotationBase<dynamic>> generators;
}

class PartAnnotationsBuilder extends AnnotationsBuilder with PartGenerator {
  const PartAnnotationsBuilder(super.generators, {super.throwOnUnresolved});
}
