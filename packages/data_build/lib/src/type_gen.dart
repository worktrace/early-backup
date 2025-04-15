import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:data_build/generator.dart';
import 'package:source_gen/source_gen.dart';

import 'type.dart';

class PubNameGenerator extends AnnotationGenerator<GeneratePubName> {
  const PubNameGenerator();

  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final name = element.displayName;
    return "const \$name\$$name = '$name';";
  }
}
