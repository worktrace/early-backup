import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:build/build.dart';
import 'package:build_type/parse.dart';
import 'package:child_type/child_type.dart';
import 'package:compat_utils/case.dart';
import 'package:nest_gen/nest_gen.dart';
import 'package:source_gen/source_gen.dart';
import 'package:yaml/yaml.dart';

import 'annotation.dart';

Builder wrapBuilder(BuilderOptions options) => LibraryBuilder(
  const PartAnnotationsBuilder([WrapGenerator()]),
  generatedExtension: '.wrap.g.dart',
);

Builder wrapLibBuilder(BuilderOptions options) {
  final rawImports = options.config['imports'];
  final imports = <String>[];
  if (rawImports != null) {
    imports.addAll((rawImports as YamlList).toList().whereType<String>());
  }

  if (imports.isEmpty) imports.add('package:flutter/widgets.dart');
  return LibraryBuilder(
    LibraryAnnotationBuilder([const WrapGenerator()], imports: imports),
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
    final typeName = annotation.peek(GenerateWrap.fieldTypeName)?.stringValue;
    final consName = annotation
        .peek(GenerateWrap.fieldConstructorName)
        ?.stringValue;

    final className = (typeName ?? element.classElement.name).camelCase;
    final constructorName = (consName ?? element.name).pascalCase;
    return '$className$constructorName';
  }

  @override
  String generateExtensionName(
    ConstructorElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) => 'Wrap${element.classElement.name}${element.name.pascalCase}';

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
          if (parameter.type.identifier != typeWidget) break;
          return '${typeWidget.name}$suffix';

        case _children:
      }
    }
    throw Exception('must have a child or children when wrap');
  }

  static const _child = 'child';
  static const _children = 'children';

  @override
  String joinInputParameters(Iterable<String> results) {
    final positional = <String>[];
    final named = <String>[];
    for (final result in results) {
      final code = result.trim();
      if (code.startsWith('{') && code.endsWith('}')) {
        named.add(code.substring(1, code.length - 1));
      } else {
        positional.add(code);
      }
    }
    final resolvedPos = positional.isEmpty ? '' : '${positional.join(',')}, ';
    final resolvedNamed = named.isEmpty ? '' : '{${named.join(',')}}';
    return '$resolvedPos$resolvedNamed';
  }

  @override
  String? generateInputParameter(ParameterElement parameter) {
    final name = parameter.name;
    if (name == _child || name == _children) return null;
    return parameter.toString();
  }

  @override
  String? generateOutputParameter(ParameterElement parameter) {
    final name = parameter.name;
    return name == _child || name == _children ? '$name: this' : '$name: $name';
  }
}
