import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:data_gen/annotation.dart';
import 'package:source_gen/source_gen.dart';

Builder parseBuilder(BuilderOptions options) {
  return LibraryBuilder(
    const ParseGenerator(),
    generatedExtension: '.parse.dart',
  );
}

class ParseGenerator extends GeneratorForAnnotation<GenerateParse> {
  const ParseGenerator();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    return '// it works';
  }
}
