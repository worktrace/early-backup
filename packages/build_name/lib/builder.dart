import 'package:analyzer/dart/element/element.dart';
import 'package:annotate_name/annotate_name.dart';
import 'package:build/build.dart';
import 'package:compat_utils/case.dart';
import 'package:compat_utils/string.dart';
import 'package:nest_gen/nest_gen.dart';
import 'package:source_gen/source_gen.dart';

Builder nameBuilder(BuilderOptions options) => LibraryBuilder(
  PartAnnotationsBuilder([NameGenerator(), LibGenerator()]),
  generatedExtension: '.name.g.dart',
);

class NameGenerator extends GenerateOnAnnotation<GenerateName> {
  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final name = element.name ?? '';
    return "const _\$name\$${name.adaptiveCodeName} = '$name';";
  }
}

class LibGenerator extends GenerateOnAnnotation<GenerateLibraryIdentifier> {
  @override
  String build(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final name = element.name.nullAsEmpty.adaptiveCodeName;
    final lib = element.library?.identifier ?? '';
    return "const _\$lib\$$name = '$lib';";
  }
}
