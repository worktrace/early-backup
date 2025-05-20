import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:build/build.dart';
import 'package:build_type/parse.dart';
import 'package:child_type/child_type.dart';
import 'package:compat_utils/case.dart';
import 'package:nest_gen/nest_gen.dart';
import 'package:source_gen/source_gen.dart';

import 'annotation.dart';

Builder wrapBuilder(BuilderOptions options) {
  return LibraryBuilder(
    const PartAnnotationsBuilder([WrapGenerator()]),
    generatedExtension: '.wrap.g.dart',
  );
}

class WrapGenerator extends GenerateOnAnnotation<GenerateWrap>
    with
        GenerateConstructor,
        GenerateTopLevelVariable,
        GenerateSet,
        GenerateConstructorSet,
        GenerateStreamExtensionConstructor {
  const WrapGenerator();

  @override
  String generateMethodName(
    ConstructorElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final className = element.classElement.name.camelCase;
    final constructorName = element.name.pascalCase;
    return '$className$constructorName';
  }

  @override
  String generateExtensionName(
    ConstructorElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) => 'Wrap${element.classElement.name}';

  @override
  String generateExtensionTarget(
    ConstructorElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    for (final parameter in element.parameters) {
      final suffix =
          parameter.type.nullabilitySuffix == NullabilitySuffix.question
          ? '?'
          : '';

      switch (parameter.name) {
        case _child:
          if (parameter.type.identifier != widgetType) break;
          return '${widgetType.name}$suffix';

        case _children:
      }
    }
    throw Exception('must have a child or children when wrap');
  }

  static const _child = 'child';
  static const _children = 'children';

  @override
  String? generateInputParameter(ParameterElement parameter) {
    final name = parameter.name;
    return name == _child || name == _children ? null : parameter.toString();
  }

  @override
  String? generateOutputParameter(ParameterElement parameter) {
    final name = parameter.name;
    return name == _child || name == _children ? '$name: $name' : '$name: this';
  }
}
