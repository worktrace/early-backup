import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
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
      if (parameter.name == 'child') {}
    }
    return '';
  }

  @override
  String generateInputParameter(ParameterElement parameter) {
    // TODO: implement generateInputParameter
    throw UnimplementedError();
  }

  @override
  String generateOutputParameter(ParameterElement parameter) {
    // TODO: implement generateOutputParameter
    throw UnimplementedError();
  }
}
