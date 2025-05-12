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

mixin GenerateConstructor<T> on GenerateOnAnnotation<T> {
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

mixin GenerateConstructorSet<T> on GenerateConstructor<T> {
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
        'annotate $T on empty top level variable: ${element.name}',
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
        '$T can only annotate on Set<Function> '
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

/// Generate an extension method that convert the class according
/// to the parameters of the specified constructor.
mixin GenerateStreamExtensionConstructor<T> on GenerateConstructor<T> {
  @override
  String buildConstructor(ConstructorElement element) {
    final type = element.returnType.toString();
    final name = element.isDefaultConstructor ? '' : element.name;
    final constructorName = name.isEmpty ? '' : '.$name';
    final extensionName = generateExtensionName(element);
    final methodName = generateMethodName(element);

    final parameters = element.declaration.parameters;
    final inputs = parameters.map(generateInputParameter).join(',');
    final outputs = parameters.map(generateOutputParameter).join(',');
    return 'extension $extensionName on $type {\n'
        '  $type $methodName({$inputs}) {\n'
        '    return $type$constructorName($outputs);\n'
        '  }\n'
        '}';
  }

  /// How to generate the name of the extension method.
  String generateMethodName(ConstructorElement element);

  /// How to generate the name of the extension.
  String generateExtensionName(ConstructorElement element);

  /// How to generate each parameter of the generated method.
  String generateInputParameter(ParameterElement parameter);

  /// How to generate each parameter used by the output constructor.
  String generateOutputParameter(ParameterElement parameter);
}
