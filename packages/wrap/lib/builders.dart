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

class WrapGenerator extends GeneratorOnAnnotation<GenerateWrap> {
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
    final type = element.returnType.toString();
    final name = element.name;
    final nameSuffix = name.isEmpty ? '' : '\$$name';

    return 'extension Wrap$type$nameSuffix on Widget {}';
  }

  String buildWrapMethod(ConstructorElement element) {
    return '';
  }

  String? buildVConstructor(DartObject raw, String name) {
    final element = raw.toFunctionValue();
    return element is ConstructorElement ? buildConstructor(element) : null;
  }

  String? buildVConstructorBaseMethod(DartObject raw) {
    final element = raw.toFunctionValue();
    return element is ConstructorElement ? buildWrapMethod(element) : null;
  }

  String? buildVConstructorSet(DartObject raw, String name) {
    final method = buildVConstructorSetBaseMethods(raw);
    if (method == null) return null;
    return method;
  }

  String? buildVConstructorSetBaseMethods(DartObject raw) => raw
      .toSetValue()
      ?.map(buildVConstructorBaseMethod)
      .nullIfEmpty
      ?.join('\n\n');

  /// Build wrap extension output based on a top level variable.
  ///
  /// This top level variable is an entry to mark which constructor to build,
  /// and such constructors are usually imported from other packages.
  String buildTopLevelVariable(TopLevelVariableElement element) {
    final raw = element.computeConstantValue();
    if (raw == null) throw WrapAnnoException(element);

    final result =
        buildVConstructor(raw, element.name) ??
        buildVConstructorSet(raw, element.name);
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
