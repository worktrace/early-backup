import 'package:analyzer/dart/element/element.dart';
import 'package:annotate_data/annotate_data.dart';
import 'package:build/build.dart';
import 'package:compat_utils/string.dart';
import 'package:nest_gen/nest_gen.dart';
import 'package:source_gen/source_gen.dart';

Builder copyBuilder(BuilderOptions options) => LibraryBuilder(
  const PartAnnotationsBuilder([CopyGenerator()]),
  generatedExtension: '.copy.g.dart',
);

class CopyGenerator extends GenerateOnAnnotation<GenerateCopy>
    with
        GenerateConstructor,
        GenerateTopLevelVariable,
        GenerateSet,
        GenerateConstructorSet,
        GenerateStreamExtensionConstructor {
  const CopyGenerator();

  @override
  String generateMethodName(
    ConstructorElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) => 'copyWith';

  @override
  String generateExtensionName(
    ConstructorElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) => 'Copy${element.classElement.name}';

  @override
  String generateInputParameter(ParameterElement parameter) {
    final name = parameter.name;
    final type = parameter.type.toString();
    return '${type.ensureSuffix('?')} $name';
  }

  @override
  String generateOutputParameter(ParameterElement parameter) {
    final name = parameter.name;
    final prefix = parameter.isNamed ? '$name: ' : '';
    return '$prefix$name ?? this.$name';
  }
}
