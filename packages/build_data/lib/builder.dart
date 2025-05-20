import 'package:analyzer/dart/element/element.dart';
import 'package:annotate_data/annotate_data.dart';
import 'package:build/build.dart';
import 'package:compat_utils/string.dart';
import 'package:nest_gen/nest_gen.dart';
import 'package:source_gen/source_gen.dart';

Builder dataBuilder(BuilderOptions options) => LibraryBuilder(
  const PartAnnotationsBuilder([
    CopyGenerator(),
    HashGenerator(),
    EqualsGenerator(),
  ]),
  generatedExtension: '.data.g.dart',
);

Builder copyBuilder(BuilderOptions options) => LibraryBuilder(
  const PartAnnotationsBuilder([CopyGenerator()]),
  generatedExtension: '.copy.g.dart',
);

Builder hashBuilder(BuilderOptions options) => LibraryBuilder(
  const PartAnnotationsBuilder([HashGenerator()]),
  generatedExtension: '.hash.g.dart',
);

Builder equalsBuilder(BuilderOptions options) => LibraryBuilder(
  const PartAnnotationsBuilder([EqualsGenerator()]),
  generatedExtension: '.equals.g.dart',
);

class CopyGenerator extends GenerateOnAnnotation<GenerateCopy>
    with
        GenerateConstructor,
        GenerateTopLevelVariable,
        GenerateSet,
        GenerateConstructorSet,
        GenerateStreamExtensionConstructor {
  const CopyGenerator();

  @override
  String generateMethodName(
    ConstructorElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) => 'copyWith';

  @override
  String generateExtensionName(
    ConstructorElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) => 'Copy${element.classElement.name}';

  @override
  String generateInputParameter(ParameterElement parameter) {
    final name = parameter.name;
    final type = parameter.type.toString();
    return '${type.ensureSuffix('?')} $name';
  }

  @override
  String generateOutputParameter(ParameterElement parameter) {
    final name = parameter.name;
    final prefix = parameter.isNamed ? '$name: ' : '';
    return '$prefix$name ?? this.$name';
  }
}

class HashGenerator extends GenerateOnAnnotation<GenerateHash>
    with GenerateClass {
  const HashGenerator();

  @override
  String buildClass(
    ClassElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element.isAbstract) throw Exception('cannot build equals on abstract');
    final includePrivate =
        annotation.peek(GenerateHashBase.fieldIncludePrivate)?.boolValue ??
        true;

    const item = 'item';
    final name = element.name;
    final code = element.fields
        .where((field) => !field.isStatic && !field.isSynthetic)
        .where((field) => includePrivate || field.isPublic)
        .map((field) => '$item.${field.name}');

    return 'int _\$hash\$$name($name $item) {\n'
        '  return Object.hashAll([${code.join(',')}]);\n'
        '}';
  }
}

class EqualsGenerator extends GenerateOnAnnotation<GenerateEquals>
    with GenerateClass {
  const EqualsGenerator();

  @override
  String buildClass(
    ClassElement element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element.isAbstract) throw Exception('cannot build equals on abstract');
    final includePrivate =
        annotation.peek(GenerateHashBase.fieldIncludePrivate)?.boolValue ??
        true;

    final name = element.name;
    final code = element.fields
        .where((field) => !field.isStatic && !field.isSynthetic)
        .where((field) => includePrivate || field.isPublic)
        .map((field) => 'a.${field.name} == b.${field.name}');

    return 'bool _\$equals\$$name($name a, Object b) {\n'
        '  return b is $name && ${code.join(' && ')};\n'
        '}';
  }
}
