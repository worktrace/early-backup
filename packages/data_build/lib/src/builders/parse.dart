import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:data_build/annotation.parse.dart';
import 'package:source_gen/source_gen.dart';

Builder parseBuilder(BuilderOptions options) => LibraryBuilder(
  const ParseGenerator(), //
  generatedExtension: '.parse.g.dart',
);

UnsupportedError unsupportedAnnoPos(Element element) {
  return UnsupportedError('unsupported annotation position: ${element.kind}');
}

class ParseGenerator extends GeneratorForAnnotation<GenerateParse> {
  const ParseGenerator();

  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final content = await super.generate(library, buildStep);
    if (content.isEmpty) return content; // Avoid empty output file.
    return "import '${buildStep.inputId.uri}';\n"
        "import 'package:source_gen/source_gen.dart' show ConstantReader;\n\n"
        '$content';
  }

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ConstructorElement) throw unsupportedAnnoPos(element);
    final type = element.type.toString();
    return '// $type parse$type()';
  }
}
