import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:data_build/generator.dart';
import 'package:source_gen/source_gen.dart';

import 'lerp.dart';

class LerpGenerator extends AnnotationGenerator<GenerateLerp> {
  const LerpGenerator();

  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) throw const AnnoPosException();
    return '// generate lerp.';
  }
}
