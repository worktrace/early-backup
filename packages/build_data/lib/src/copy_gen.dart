import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:compat_utils/string.dart';
import 'package:nest_gen/nest_gen.dart';
import 'package:source_gen/source_gen.dart';

import 'copy.dart';

Builder copyBuilder(BuilderOptions options) => LibraryBuilder(
  const PartAnnotationsBuilder([CopyGenerator()]),
  generatedExtension: '.copy.g.dart',
);

class CopyGenerator extends GenerateOnAnnotation<GenerateCopy> {
  const CopyGenerator();

  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ConstructorElement) {
      throw const AnnotationPositionException<GenerateCopy>();
    }

    final type = element.returnType.toString();
    final name = element.isDefaultConstructor ? '' : element.name;
    final constructorName = name.isEmpty ? '' : '.$name';

    final inputs = element.declaration.parameters.map(_genInput).join(',');
    final outputs = element.declaration.parameters.map(_genOutput).join(',');
    return 'extension Copy$type on $type {\n'
        '  $type copyWith({$inputs}) {\n'
        '    return $type$constructorName($outputs);\n'
        '  }\n'
        '}';
  }

  String _genInput(ParameterElement parameter) {
    final name = parameter.name;
    final type = parameter.type.toString();
    return '${type.ensureSuffix('?')} $name';
  }

  String _genOutput(ParameterElement parameter) {
    final name = parameter.name;
    final prefix = parameter.isNamed ? '$name: ' : '';
    return '$prefix$name ?? this.$name';
  }
}
