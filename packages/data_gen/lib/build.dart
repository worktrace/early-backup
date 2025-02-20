import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/name.dart';

Builder nameBuilder(BuilderOptions options) {
  return LibraryBuilder(
    const NameGenerator(),
    generatedExtension: '.name.dart',
  );
  // return SharedPartBuilder([const NameGenerator()], 'name');
}

class NameGenerator extends GeneratorForAnnotation<GenerateName> {
  const NameGenerator();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    return '''
      // const ${element.displayName} = '${element.displayName}';
    ''';
  }
}
