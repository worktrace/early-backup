import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:compat_utils/string.dart';
import 'package:nest_gen/generator.dart';
import 'package:source_gen/source_gen.dart';

import 'copy.dart';

class CopyGenerator extends AnnotationGenerator<GenerateCopy> {
  const CopyGenerator();

  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ConstructorElement) throw const AnnoPosException();

    final type = element.returnType.toString();
    final name = element.isDefaultConstructor ? '' : element.name;
    final constructorName = name.isEmpty ? '' : '.$name';

    const template = '_template';
    final inputs = element.declaration.parameters.map(_generateInput).join(',');
    final outputs = element.declaration.parameters
        .map((parameter) => _generateOutput(parameter, template))
        .join(',');

    return 'mixin _\$Copy\$$type implements ${Copyable.name} {\n'
        '  $type get $template => this as $type;\n'
        '  \n'
        '  @override $type copyWith({$inputs}) {\n'
        '    return $type$constructorName($outputs);\n'
        '  }\n'
        '}';
  }

  String _generateInput(ParameterElement parameter) {
    final name = parameter.name;
    final type = parameter.type.toString();
    return '${type.ensureSuffix('?')} $name';
  }

  String _generateOutput(ParameterElement parameter, String template) {
    final name = parameter.name;
    final prefix = parameter.isNamed ? '$name: ' : '';
    return '$prefix$name ?? $template.$name';
  }
}
