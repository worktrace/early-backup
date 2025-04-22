import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:compat_utils/iterable.dart';
import 'package:nest_gen/builder.dart';
import 'package:nest_gen/generator.dart';
import 'package:source_gen/source_gen.dart';

import 'annotation.dart';

Builder wrapBuilder(BuilderOptions options) {
  return LibraryBuilder(
    const PartDataBuilder([WrapGenerator()]),
    generatedExtension: '.wrap.g.dart',
  );
}

class WrapGenerator extends AnnotationGenerator<GenerateWrap> {
  const WrapGenerator();

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
        return buildTopLevelVariable(element);

      default:
        throw const AnnoPosException();
    }
  }

  String buildConstructor(ConstructorElement element) {
    return '';
  }

  String? buildVConstructor(DartObject raw) {
    final element = raw.toFunctionValue();
    return element is ConstructorElement ? buildConstructor(element) : null;
  }

  String? buildVConstructors(DartObject raw) => raw
      .toSetValue() //
      ?.map(buildVConstructor)
      .nullIfEmpty
      ?.join('\n\n');

  String buildTopLevelVariable(TopLevelVariableElement element) {
    final raw = element.computeConstantValue();
    if (raw == null) throw WrapAnnoException(element);
    final result = buildVConstructor(raw) ?? buildVConstructors(raw);
    if (result != null) throw WrapAnnoException(element);
    return result!;
  }
}

class WrapAnnoException implements Exception {
  const WrapAnnoException(this.element);

  final Element element;

  @override
  String toString() => 'invalid wrap annotation position or format: $element';
}
