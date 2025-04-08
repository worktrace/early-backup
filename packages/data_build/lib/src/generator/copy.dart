import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:data_build/annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'abstraction.dart';

class CopyGenerator extends AnnotationGenerator<GenerateCopy> {
  const CopyGenerator();

  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    return '// it works';
  }
}
