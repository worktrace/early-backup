import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:annotate_lerp/annotate_lerp.dart';
import 'package:annotate_lerp/register_lerp.dart';
import 'package:annotate_type/annotate_type.dart';
import 'package:build/build.dart';
import 'package:compat_utils/iterable.dart';
import 'package:compat_utils/string.dart';
import 'package:nest_gen/nest_gen.dart';
import 'package:source_gen/source_gen.dart';

import 'avoid_nullable.register.g.dart';

Builder lerpBuilder(BuilderOptions options) => LibraryBuilder(
  const PartAnnotationsBuilder([LerpGenerator()]),
  generatedExtension: '.lerp.g.dart',
  options: options,
);

class LerpGenerator extends GenerateOnAnnotatedConstructor<GenerateLerp>
    with GenerateConstructorSet {
  const LerpGenerator();

  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    switch (element) {
      case final ConstructorElement element:
        return buildConstructor(element, annotation, buildStep);

      case final TopLevelVariableElement element:
        final result = buildConstructorSet(element, annotation, buildStep);
        if (result.isNotEmpty) return result.join('\n\n');
        throw Exception(
          'annotate $GenerateLerp on '
          'empty top level variable: ${element.name}',
        );

      default:
        throw const AnnotationPositionException<GenerateLerp>();
    }
  }

  @override
  String buildNonSourceConstructor(
    ConstructorElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) => buildConstructor(
    element,
    annotation,
    buildStep,
    private: false,
    annotateBuildInLerp: true,
  );

  @override
  String buildConstructor(
    ConstructorElement element,
    ConstantReader annotation,
    BuildStep buildStep, {
    bool private = true,
    bool annotateBuildInLerp = false,
  }) {
    final rawClass = element.returnType.element;
    final parameters = () sync* {
      final fields = rawClass.fields
          .map((field) => MapEntry(field.name, field.type))
          .asMap;

      for (final parameter in element.parameters) {
        final name = parameter.name;
        final type = parameter.type;
        if (fields.containsKey(name) && type == fields[name]) {
          yield buildLerpParameter(parameter);
        }
      }
    }();

    final className = rawClass.name;
    final functionName = private ? '_\$lerp\$$className' : 'lerp$className';
    final constructorName = element.name.isEmpty ? '' : '.${element.name}';

    return '${annotateBuildInLerp ? '@${GenerateRegisterLerp.shortcut}\n' : ''}'
        '$className $functionName($className a, $className b, double t) {\n'
        '  return $className$constructorName(${parameters.join(',')});\n'
        '}';
  }

  /// Build a single lerp parameter.
  ///
  /// 1. Apply build in lerp functions ([buildInLerpFunctions])
  /// if there's registered one.
  /// 2. When the type is not defined in `dart:ui` or `package:flutter`, it'll
  /// use the lerp factory constructor directly without nullable assertion.
  /// 3. When lerp `String`, `bool`, `Function` or `Enum`,
  /// it will change at `0.5`.
  String buildLerpParameter(ParameterElement element) {
    final name = element.name;
    final type = element.type;
    final typeName = type.toString();
    final namedPrefix = element.isNamed ? '$name: ' : '';

    if (type.isDartCoreString ||
        type.isDartCoreBool ||
        type.isDartCoreFunction ||
        type.element?.kind == ElementKind.ENUM) {
      return '${namedPrefix}t < 0.5 ? a.$name : b.$name';
    }

    // Maybe apply build in lerp functions.
    final typeLibID = type.element?.library?.identifier;
    final match = buildInLerpFunctions.match(typeName, typeLibID);
    if (match != null) return '$namedPrefix$match(a.$name, b.$name, t)';

    // Use default lerp provided by dart:ui or package:flutter.
    final raw =
        typeLibID == 'dart:ui' ||
        typeLibID?.beforeOrAll('/') == 'package:flutter';
    final nullable = type.nullabilitySuffix == NullabilitySuffix.question;
    final className = nullable ? typeName.removeSuffix('?') : typeName;
    final suffix = !nullable && raw ? '!' : '';
    return '$namedPrefix$className.lerp(a.$name, b.$name, t)$suffix';
  }
}

extension TypeIdentifierMatch on Map<String, TypeIdentifier> {
  String? match(String typeName, String? libraryIdentifier) {
    for (final entry in entries) {
      final type = entry.value;
      final name = type.name;
      final lib = type.libraryIdentifier;
      if (name == typeName && lib == libraryIdentifier) return entry.key;
    }
    return null;
  }
}
