import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generate_annotation.dart';

abstract class GenerateOnAnnotatedTopLevelVariable<T>
    extends GenerateOnAnnotation<T>
    with GenerateTopLevelVariable {
  const GenerateOnAnnotatedTopLevelVariable();
}

mixin GenerateTopLevelVariable<T> on GenerateOnAnnotationBase<T> {
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

mixin GenerateSet<T> on GenerateTopLevelVariable<T> {
  @override
  String buildTopLevelVariable(
    TopLevelVariableElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final s = element.computeConstantValue()?.toSetValue();
    if (s == null) throw Exception('$T can only annotate on Set');
    return joinSetItems(s.map((i) => buildSetItem(i, annotation, buildStep)));
  }

  String joinSetItems(Iterable<String?> results) {
    return results.whereType<String>().join('\n\n');
  }

  String? buildSetItem(
    DartObject element,
    ConstantReader annotation,
    BuildStep buildStep,
  );
}
