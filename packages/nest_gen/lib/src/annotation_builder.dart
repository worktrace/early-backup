/// @docImport 'package:analyzer/dart/element/element.dart';
/// @docImport 'package:meta/meta_meta.dart';
library;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

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

class LibraryAnnotationBuilder extends AnnotationsBuilder {
  const LibraryAnnotationBuilder(
    super.generators, {
    this.imports = const [],
    super.throwOnUnresolved,
  });

  final Iterable<String> imports;

  @override
  String? generate(LibraryReader library, BuildStep buildStep) {
    final result = super.generate(library, buildStep);
    if (result == null) return null;
    final sortedImports = imports.toList()..sort();
    final importLines = sortedImports.map((item) => "import '$item';");
    const prefix = '// ignore_for_file: implementation_imports generated.';
    return '$prefix\n\n${importLines.join('\n')}\n\n$result';
  }
}
