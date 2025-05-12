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

class CopyGenerator extends GenerateOnAnnotatedConstructor<GenerateCopy>
    with GenerateStreamExtensionConstructor, GenerateConstructorSet {
  const CopyGenerator();

  @override
  String get methodName => 'copyWith';

  @override
  String generateExtensionName(ClassElement classElement) {
    return 'Copy${classElement.name}';
  }

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
