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
