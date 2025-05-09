import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// Define how to generate data according to an annotation of type [T].
///
/// Override the [build] method to define
/// how to build on an parsed element annotated with an annotation of type [T].
/// When there's multiple annotation with the same specified type [T],
/// or match the override [typeChecker] rule, it will only use the first one.
abstract class GenerateOnAnnotation<T> {
  const GenerateOnAnnotation();

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

mixin GenerateConstructor<AnnoT> on GenerateOnAnnotation<AnnoT> {
  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is ConstructorElement) return buildConstructor(element);
    return super.build(element, annotation, buildStep);
  }

  String buildConstructor(ConstructorElement element);
}

mixin GenerateConstructorSet<AnnoT> on GenerateConstructor<AnnoT> {
  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is TopLevelVariableElement) {
      final result = buildConstructorSet(element);
      if (result.isNotEmpty) return result.join('\n\n');
      throw Exception(
        'annotate $AnnoT on empty top level variable: ${element.name}',
      );
    }
    return super.build(element, annotation, buildStep);
  }

  /// Define how to build on a [Set] of constructors,
  /// usually used for building constructors that
  /// are not defined in current library.
  Iterable<String> buildConstructorSet(TopLevelVariableElement element) sync* {
    final items = element.computeConstantValue()?.toSetValue();
    if (items == null) {
      throw Exception(
        '$AnnoT can only annotate on Set<Function> '
        'when annotate on top level variables',
      );
    }
    for (final item in items) {
      final constructor = item.toFunctionValue();
      if (constructor is! ConstructorElement) continue;
      yield buildNonSourceConstructor(constructor);
    }
  }

  /// Define how to build constructor when it's not annotated on
  /// the source code of such constructor, such as
  /// an annotated set of constructors build by [buildConstructorSet] method.
  /// It will redirect to [buildConstructor] by default,
  /// and you can also override this method
  /// to customize different build strategy.
  String buildNonSourceConstructor(ConstructorElement element) {
    return buildConstructor(element);
  }
}
