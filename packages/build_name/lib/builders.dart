import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:nest_gen/nest_gen.dart';
import 'package:source_gen/source_gen.dart';

import 'annotation.dart';

Builder nameBuilder(BuilderOptions options) => LibraryBuilder(
  const PartAnnotationsBuilder([NameGenerator(), LibGenerator()]),
  generatedExtension: '.name.g.dart',
);

class NameGenerator extends GenerateOnAnnotation<GenerateName> {
  const NameGenerator();

  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final name = element.displayName;
    return "const _\$name\$$name = '$name';";
  }
}

class LibGenerator extends GenerateOnAnnotation<GenerateLib> {
  const LibGenerator();

  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final name = element.displayName;
    final lib = element.library?.identifier;
    return "const _\$lib\$$name = '$lib';";
  }
}
