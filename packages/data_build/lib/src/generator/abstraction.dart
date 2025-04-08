import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

typedef AnnotationBuilder =
    String Function(
      Element element,
      ConstantReader annotation,
      BuildStep buildStep,
    );

class AnnotationGenerator {
  const AnnotationGenerator({required this.typeChecker, required this.builder});

  final TypeChecker typeChecker;
  final AnnotationBuilder builder;

  String? maybeBuild(
    Element element,
    BuildStep buildStep, {
    bool throwOnUnresolved = true,
  }) {
    final result = typeChecker.firstAnnotationOf(
      element,
      throwOnUnresolved: throwOnUnresolved,
    );
    if (result == null) return null;
    return builder(element, ConstantReader(result), buildStep);
  }
}

class RecursiveAnnotationGenerator extends Generator {
  const RecursiveAnnotationGenerator(
    this.generators, {
    this.throwOnUnresolved = true,
  });

  final Iterable<AnnotationGenerator> generators;
  final bool throwOnUnresolved;

  @override
  String? generate(LibraryReader library, BuildStep buildStep) {
    final result = _generate(
      library.element,
      buildStep,
      throwOnUnresolved: throwOnUnresolved,
    );
    return result.isEmpty ? null : result.join('\n\n');
  }

  /// The annotation of the [element] itself will not be recognized here.
  /// It will only process the children layer, and recursive when necessary.
  Iterable<String> _generate(
    Element element,
    BuildStep buildStep, {
    bool throwOnUnresolved = true,
  }) sync* {
    for (final child in element.children) {
      for (final generator in generators) {
        final result = generator.maybeBuild(
          child,
          buildStep,
          throwOnUnresolved: throwOnUnresolved,
        );
        if (result != null) yield result;
      }
      yield* _generate(child, buildStep, throwOnUnresolved: throwOnUnresolved);
    }
  }
}
