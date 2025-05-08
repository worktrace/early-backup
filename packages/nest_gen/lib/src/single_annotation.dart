import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'composed_generator.dart';

abstract class ComposedSingleAnnotationGenerator<T> extends ComposedGenerator {
  const ComposedSingleAnnotationGenerator({this.throwOnUnresolved = false});

  final bool throwOnUnresolved;

  TypeChecker get typeChecker => TypeChecker.fromRuntime(T);
}

abstract class TopLevelSingleAnnotationGenerator<T>
    extends ComposedSingleAnnotationGenerator<T> {
  const TopLevelSingleAnnotationGenerator();

  @override
  Iterable<String> generateComponents(
    LibraryReader library,
    BuildStep buildStep,
  ) {
    final b = buildStep;
    return library
        .annotatedWith(typeChecker, throwOnUnresolved: throwOnUnresolved)
        .map((i) => generateForAnnotatedElement(i.element, i.annotation, b));
  }

  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  );
}
