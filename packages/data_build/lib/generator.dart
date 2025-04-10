import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:meta/meta_meta.dart';
import 'package:source_gen/source_gen.dart';

abstract class AnnotationGenerator<T> {
  const AnnotationGenerator();

  TypeChecker get typeChecker => TypeChecker.fromRuntime(T);

  String build(Element element, ConstantReader annotation, BuildStep buildStep);

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
    return build(element, ConstantReader(result), buildStep);
  }
}

abstract class RecursiveAnnotationGenerator extends Generator {
  const RecursiveAnnotationGenerator({this.throwOnUnresolved = true});

  final bool throwOnUnresolved;

  Iterable<AnnotationGenerator<dynamic>> get generators;

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

/// Throw when the annotation position is invalid.
///
/// The valid position of an annotation should be indicated by the [Target]
/// annotation provided by `package:meta`.
/// And it is supposed to be check before using the parsed [Element]
/// and assert the type of the source element.
class AnnoPosException implements Exception {
  const AnnoPosException();

  @override
  String toString() => 'invalid annotation position';
}
