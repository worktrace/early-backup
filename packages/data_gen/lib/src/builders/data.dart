import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:data_gen/annotation.dart';
import 'package:source_gen/source_gen.dart';

Builder dataBuilder(BuilderOptions options) {
  return LibraryBuilder(
    const DataGenerator(),
    generatedExtension: '.data.dart',
  );
}

class DataGenerator extends GeneratorForAnnotation<AnnotationToParse> {
  const DataGenerator();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    return '';
  }
}
