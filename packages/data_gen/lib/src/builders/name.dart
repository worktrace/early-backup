import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:data_gen/annotation.dart';
import 'package:path/path.dart';
import 'package:source_gen/source_gen.dart';

Builder nameBuilder(BuilderOptions options) {
  return LibraryBuilder(
    const NameGenerator(),
    generatedExtension: '.name.dart',
  );
}

class NameGenerator extends GeneratorForAnnotation<GenerateName> {
  const NameGenerator();

  /// Specify `part of` for the generated code file.
  /// The generate code file should beside the source library file.
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final result = await super.generate(library, buildStep);
    return [
      "part of '${basename(library.element.identifier)}';",
      _generateLibraryIdentifier(library.element),
      result,
    ].join('\n\n');
  }

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    switch (element) {
      case ClassElement _:
        return _generateClassName(element);
      case TopLevelVariableElement _:
        return _generateTopLevelVariableName(element);
      default:
        throw Exception('unsupported element type: ${element.runtimeType}');
    }
  }

  String _generateLibraryIdentifier(Element element) {
    final identifier = element.library?.identifier;
    if (identifier == null) throw Exception('cannot parse library identifier');
    const comment = '// ignore: unused_element may not be used.';
    return '$comment\n'
        "const _\$libraryIdentifier = '$identifier';";
  }

  String _generateClassName(ClassElement element) {
    final value = element.displayName;
    final name = '_\$$value\$className';
    return "const $name = '$value';";
  }

  String _generateTopLevelVariableName(TopLevelVariableElement element) {
    final value = element.displayName;
    final name = '_\$$value\$topLevelVariableName';
    return "const $name = '$value';";
  }
}
