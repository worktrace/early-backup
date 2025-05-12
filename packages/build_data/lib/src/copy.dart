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

class CopyGenerator extends GenerateOnAnnotatedConstructor<GenerateCopy> {
  const CopyGenerator();

  @override
  String buildConstructor(ConstructorElement element) {
    final type = element.returnType.toString();
    final name = element.isDefaultConstructor ? '' : element.name;
    final constructorName = name.isEmpty ? '' : '.$name';

    final parameters = element.declaration.parameters;
    final inputs = parameters.map(generateInputParameter).join(',');
    final outputs = parameters.map(generateOutputParameter).join(',');
    return 'extension Copy$type on $type {\n'
        '  $type copyWith({$inputs}) {\n'
        '    return $type$constructorName($outputs);\n'
        '  }\n'
        '}';
  }

  String generateInputParameter(ParameterElement parameter) {
    final name = parameter.name;
    final type = parameter.type.toString();
    return '${type.ensureSuffix('?')} $name';
  }

  String generateOutputParameter(ParameterElement parameter) {
    final name = parameter.name;
    final prefix = parameter.isNamed ? '$name: ' : '';
    return '$prefix$name ?? this.$name';
  }
}
