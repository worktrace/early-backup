import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:data_build/generator.dart';
import 'package:source_gen/source_gen.dart';

import 'name.dart';

class NameGenerator extends AnnotationGenerator<GenerateName> {
  const NameGenerator();

  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final name = element.displayName;
    return "const _\$name\$$name = '$name';";
  }
}
