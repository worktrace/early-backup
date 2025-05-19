import 'package:analyzer/dart/element/element.dart';
import 'package:annotate_data/annotate_data.dart';
import 'package:build/build.dart';
import 'package:nest_gen/nest_gen.dart';
import 'package:source_gen/source_gen.dart';

Builder equalsBuilder(BuilderOptions options) => LibraryBuilder(
  const PartAnnotationsBuilder([EqualsGenerator()]),
  generatedExtension: '.equals.g.dart',
);

class EqualsGenerator extends GenerateOnAnnotation<GenerateEquals>
    with GenerateClass {
  const EqualsGenerator();

  @override
  String buildClass(
    ClassElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element.isAbstract) {
      throw Exception('cannot build equals on abstract class');
    }

    final includePrivate =
        annotation.peek(GenerateEquals.fieldIncludePrivate)?.boolValue ?? true;

    final name = element.name;
    final code = element.fields
        .where((field) => !field.isStatic)
        .where((field) => includePrivate || field.isPublic)
        .map((field) => 'a.${field.name} != b.${field.name}');

    return 'bool _\$equals\$$name($name a, Object b) {\n'
        '  return b is $name && ${code.join(' && ')};\n'
        '}';
  }
}
