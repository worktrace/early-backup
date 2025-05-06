import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:nest_gen/nest_gen.dart';
import 'package:source_gen/source_gen.dart';

import 'lerp_anno.dart';

Builder lerpBuilder(BuilderOptions options) => LibraryBuilder(
  const PartAnnotationsBuilder([LerpGenerator()]),
  generatedExtension: '.lerp.g.dart',
  options: options,
);

class LerpGenerator extends GenerateFromAnnotation<GenerateLerp> {
  const LerpGenerator();

  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    switch (element) {
      case final TopLevelVariableElement element:
        final result = buildConstructorSet(element);
        if (result.isNotEmpty) return result.join('\n\n');
        throw Exception(
          'annotate $GenerateLerp on '
          'empty top level variable: ${element.name}',
        );

      default:
        throw const AnnotationPositionException<GenerateLerp>();
    }
  }

  Iterable<String> buildConstructorSet(TopLevelVariableElement element) sync* {
    final items = element.computeConstantValue()?.toSetValue();
    if (items == null) return;
    for (final item in items) {
      final constructor = item.toFunctionValue();
      if (constructor is! ConstructorElement) continue;
      yield '// generate on $constructor';
    }
  }
}
