import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import 'composed_generator.dart';

/// Define how to generate data from an annotation of specified type [T].
///
/// Override the [build] method to define
/// how to build on an parsed element annotated with an annotation of type [T].
/// When there's multiple annotation with the same specified type [T],
/// or match the override [typeChecker] rule, it will only use the first one.
abstract class GenerateFormAnnotation<T> {
  const GenerateFormAnnotation();

  /// Define how to check the type [T].
  TypeChecker get typeChecker => TypeChecker.fromRuntime(T);

  /// How to build on a single annotation of type [T].
  String build(Element element, ConstantReader annotation, BuildStep buildStep);

  /// Check type and build when necessary.
  ///
  /// 1. When there's multiple annotation with the same specified type [T],
  /// or match the override [typeChecker] rule, it will only use the first one.
  /// 2. When there's nothing to build, it will return null.
  /// 3. It's strongly not recommended to override this method directly.
  /// You may consider override the [build] method or the [typeChecker] getter.
  @protected
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

abstract class ComposedAnnotationGenerator extends ComposedGenerator {
  const ComposedAnnotationGenerator({this.throwOnUnresolved = true});

  final bool throwOnUnresolved;

  Iterable<GenerateFormAnnotation<dynamic>> get generators;
}

abstract class TopLevelAnnotationGenerator extends ComposedAnnotationGenerator {
  const TopLevelAnnotationGenerator({super.throwOnUnresolved});

  @override
  Iterable<String> generateComponents(
    LibraryReader library,
    BuildStep buildStep,
  ) sync* {
    for (final element in library.allElements) {
      for (final generator in generators) {
        final result = generator.maybeBuild(
          element,
          buildStep,
          throwOnUnresolved: throwOnUnresolved,
        );
        if (result != null) yield result;
      }
    }
  }
}

/// Generate recursively from multiple [GenerateFormAnnotation]s.
///
/// If your generating strategy is simple enough and works like
/// the raw [GeneratorForAnnotation],
/// you may consider [TopLevelAnnotationGenerator], which is more efficient.
/// This generator will recursively process all children elements of a library.
abstract class RecursiveAnnotationGenerator
    extends ComposedAnnotationGenerator {
  const RecursiveAnnotationGenerator({super.throwOnUnresolved});

  @override
  Iterable<String> generateComponents(
    LibraryReader library,
    BuildStep buildStep,
  ) => generateRootElement(
    library.element,
    buildStep,
    throwOnUnresolved: throwOnUnresolved,
  );

  /// Generate code recursively based on the root [element] of a library.
  ///
  /// The root [element] is supposed to be at the root of a library
  /// (from a [LibraryReader]).
  /// The annotation of the [element] itself will not be recognized here.
  /// It will only process the children layer, and recursive when necessary.
  @protected
  Iterable<String> generateRootElement(
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
      yield* generateRootElement(
        child,
        buildStep,
        throwOnUnresolved: throwOnUnresolved,
      );
    }
  }
}
