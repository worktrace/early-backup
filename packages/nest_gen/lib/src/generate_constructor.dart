import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:compat_utils/iterable.dart';
import 'package:source_gen/source_gen.dart';

import 'generate_annotation.dart';
import 'generate_variable.dart';

mixin GenerateConstructor<T> on GenerateOnAnnotationBase<T> {
  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) => element is ConstructorElement
      ? buildConstructor(element, annotation, buildStep)
      : super.build(element, annotation, buildStep);

  String buildConstructor(
    ConstructorElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  );
}

mixin GenerateConstructorSet<T> on GenerateConstructor<T>, GenerateSet<T> {
  @override
  String? buildSetItem(
    DartObject element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final constructor = element.toFunctionValue();
    if (constructor is ConstructorElement) {
      return buildNonSourceConstructor(constructor, annotation, buildStep);
    }
    return null;
  }

  /// Define how to build constructor when it's not annotated on
  /// the source code of such constructor, such as
  /// an annotated set of constructors build by [buildTopLevelVariable] method.
  /// It will redirect to [buildConstructor] by default,
  /// and you can also override this method
  /// to customize different build strategy.
  String buildNonSourceConstructor(
    ConstructorElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) => buildConstructor(element, annotation, buildStep);
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
  String buildConstructor(
    ConstructorElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final type = element.returnType.toString();
    final name = element.isDefaultConstructor ? '' : element.name;
    final constructorName = name.isEmpty ? '' : '.$name';
    final extensionName = generateExtensionName(element, annotation, buildStep);
    final methodName = generateMethodName(element, annotation, buildStep);
    final target = generateExtensionTarget(element, annotation, buildStep);

    final parameters = element.declaration.parameters;
    final inputs = parameters.map(generateInputParameter).whereType<String>();
    final outputs = parameters.map(generateOutputParameter).whereType<String>();

    return 'extension $extensionName on $target {\n'
        '  $type $methodName({${inputs.join(',')}}) {\n'
        '    return $type$constructorName(${outputs.join(',')});\n'
        '  }\n'
        '}';
  }

  /// How to generate the name of the extension method.
  String generateMethodName(
    ConstructorElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  );

  /// How to generate the name of the extension.
  String generateExtensionName(
    ConstructorElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  );

  /// How to generate the target of the extension,
  /// which means what type should it extension onto.
  /// Default to the return type of the constructor.
  String generateExtensionTarget(
    ConstructorElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) => element.returnType.toString();

  /// How to generate each parameter of the generated method.
  String? generateInputParameter(ParameterElement parameter);

  /// How to generate each parameter used by the output constructor.
  String? generateOutputParameter(ParameterElement parameter);
}
