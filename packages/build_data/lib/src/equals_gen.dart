import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:nest_gen/generator.dart';
import 'package:source_gen/source_gen.dart';

import 'equals.dart';

class EqualsGenerator extends GeneratorOnAnnotation<GenerateEquals> {
  const EqualsGenerator();

  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) throw const AnnoPosException();

    final name = element.name;
    final code = element.fields
        .map((f) => 'a.${f.name} != b.${f.name}')
        .join(' && ');

    return 'bool _\$equals\$$name($name a, $name b) => $code;';
  }

  String buildEqualsField(FieldElement field) {
    final name = field.name;
    return 'if (this.$name != other.$name) return false;';
  }
}
