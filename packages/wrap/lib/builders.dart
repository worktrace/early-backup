import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
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
      case final TopLevelVariableElement element:
        return buildTopLevelVariable(element);
      default:
        throw const AnnoPosException();
    }
  }

  String buildTopLevelVariable(TopLevelVariableElement element) {
    return '// build top level variable';
  }
}
