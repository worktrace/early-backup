import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

abstract class SingleAnnotationGenerator {
  const SingleAnnotationGenerator({required this.typeChecker});

  SingleAnnotationGenerator.from(Type runtimeType)
    : typeChecker = TypeChecker.fromRuntime(runtimeType);

  final TypeChecker typeChecker;

  String? generate(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  );
}

extension RecursiveAnnotatedElements on Element {
  /// Parse annotated element recursively.
  ///
  /// Parse all element annotated with corresponding annotation satisfies
  /// the [typeChecker] and return as [AnnotatedElement].
  /// It will parse all elements recursively, which might cost performance.
  Iterable<AnnotatedElement> recursiveAnnotatedWith(
    TypeChecker typeChecker, {
    bool throwOnUnresolved = true,
  }) sync* {
    for (final child in children) {
      final result = typeChecker.firstAnnotationOf(
        child,
        throwOnUnresolved: throwOnUnresolved,
      );
      if (result != null) yield AnnotatedElement(ConstantReader(result), child);
      yield* child.recursiveAnnotatedWith(typeChecker);
    }
  }
}

class RecursiveAnnotationGenerator extends Generator {
  const RecursiveAnnotationGenerator(
    this.generators, {
    this.throwOnUnresolved = true,
  });

  final Iterable<SingleAnnotationGenerator> generators;
  final bool throwOnUnresolved;

  @override
  String? generate(LibraryReader library, BuildStep buildStep) {
    // ignore: unused_local_variable temp
    final annotatedElements = library.element.recursiveAnnotatedWith(
      TypeChecker.any(generators.map((g) => g.typeChecker)),
      throwOnUnresolved: throwOnUnresolved,
    );

    return null;
  }
}
