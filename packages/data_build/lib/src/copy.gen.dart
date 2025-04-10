import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
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
    final functionName = name.isEmpty ? '' : '_$name';
    final constructorName = name.isEmpty ? '' : '.$name';
    return '$type _\$copy_$type$functionName() => $type$constructorName();';
  }
}
