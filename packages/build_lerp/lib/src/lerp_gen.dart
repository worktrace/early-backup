import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build_lerp/src/build_in_anno.dart';
import 'package:compat_utils/iterable.dart';
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
      case final ConstructorElement element:
        return buildConstructor(element);

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
      yield buildConstructor(
        constructor,
        private: false,
        annotateBuildInLerp: true,
      );
    }
  }

  String buildConstructor(
    ConstructorElement element, {
    bool private = true,
    bool annotateBuildInLerp = false,
  }) {
    final rawClass = element.returnType.element;
    final parameters = () sync* {
      final fields = rawClass.fields
          .map((field) => MapEntry(field.name, field.type))
          .asMap;

      for (final parameter in element.parameters) {
        final name = parameter.name;
        final type = parameter.type;
        if (!fields.containsKey(name) || type != fields[name]) continue;
      }

      yield '1,1';
    }();

    final className = rawClass.name;
    final functionName = private ? '_\$lerp\$$className' : 'lerp$className';
    final constructorName = element.name.isEmpty ? '' : '.${element.name}';
    const buildInLerp = GenerateBuildInLerp.shortcutName;

    return '${annotateBuildInLerp ? '@$buildInLerp\n' : ''}'
        '$className $functionName($className a, $className b, double t) {\n'
        '  return $className$constructorName(${parameters.join(',')});\n'
        '}';
  }
}
