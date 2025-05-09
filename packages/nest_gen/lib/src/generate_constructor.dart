import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:compat_utils/iterable.dart';
import 'package:source_gen/source_gen.dart';

import 'annotation_builder.dart';
import 'annotation_generator.dart';

/// Like [GenerateOnAnnotation], but ensure [build] implemented
/// by throwing [AnnotationPositionException] by default.
/// Override and call super to specify corresponding building logics.
abstract class GenerateOnAnnotationBase<T> extends GenerateOnAnnotation<T> {
  const GenerateOnAnnotationBase();

  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) => throw AnnotationPositionException<T>();
}

abstract class GenerateOnAnnotatedConstructor<T>
    extends GenerateOnAnnotationBase<T>
    with GenerateConstructor<T> {
  const GenerateOnAnnotatedConstructor();
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

extension ConstructorUtils on ConstructorElement {
  /// The class element of current constructor.
  ClassElement get classElement => returnType.element as ClassElement;

  /// Parameters of current constructor that are also a field in the class.
  ///
  /// A parameter here will only be included when it has the same name
  /// as certain field of the class, and they also have the same type.
  /// And the returned value is a map of parameter name to parameter type.
  Map<String, DartType> get compatParameters {
    return _compatParameters.asMap;
  }

  Iterable<MapEntry<String, DartType>> get _compatParameters sync* {
    final f = classElement.fields.map((f) => MapEntry(f.name, f.type)).asMap;
    for (final p in parameters) {
      if (f.containsKey(p.name) && f[p.name] == p.type) {
        yield MapEntry(p.name, p.type);
      }
    }
  }
}
