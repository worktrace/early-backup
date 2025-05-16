import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generate_annotation.dart';

mixin GenerateClass<T> on GenerateOnAnnotationBase<T> {
  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) => element is ClassElement
      ? buildClass(element, annotation, buildStep)
      : super.build(element, annotation, buildStep);

  String buildClass(
    ClassElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  );
}
