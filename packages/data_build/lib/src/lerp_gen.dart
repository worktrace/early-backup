import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:data_build/generator.dart';
import 'package:flutter/widgets.dart' show Radius;
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
    if (element is! ConstructorElement) throw const AnnoPosException();

    final type = element.returnType.toString();
    const demo = Radius.circular(12);

    return '// $type _\$lerp\$$type($type a, $type b, double t) => $demo;';
  }
}
