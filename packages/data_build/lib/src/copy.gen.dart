import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:compat_utils/format/string.dart';
import 'package:data_build/generator.dart';
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

    final parameters = element.declaration.parameters
        .where((p) => p.isInitializingFormal || p.isSuperFormal)
        .map((p) => (p.name, p.type.toString()));

    final inputs = parameters
        .map((p) => '${p.$2.ensureSuffix('?')} ${p.$1},')
        .join('\n');

    const template = '_template';
    final outputs = parameters
        .map((p) => '${p.$1}: ${p.$1} ?? $template.${p.$1},')
        .join('\n');

    final t = '$type get $template => this as $type;';
    final m = '$type copyWith({$inputs}) => $type$constructorName($outputs);';
    return 'mixin _\$Copy\$$type { $t $m }';
  }
}
