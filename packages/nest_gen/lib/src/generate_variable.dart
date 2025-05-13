import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generate_annotation.dart';

abstract class GenerateOnAnnotatedTopLevelVariable<T>
    extends GenerateOnAnnotationBase<T>
    with GenerateTopLevelVariable {
  const GenerateOnAnnotatedTopLevelVariable();
}

mixin GenerateTopLevelVariable<T> on GenerateOnAnnotation<T> {
  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) => element is TopLevelVariableElement
      ? buildTopLevelVariable(element, annotation, buildStep)
      : super.build(element, annotation, buildStep);

  String buildTopLevelVariable(
    TopLevelVariableElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  );
}

mixin GenerateSet<T> on GenerateOnAnnotation<T> {
  Iterable<String> buildSet(TopLevelVariableElement element);
}
