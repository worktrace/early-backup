import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart';
import 'package:source_gen/source_gen.dart';

import 'annotation.dart';

Builder nameBuilder(BuilderOptions options) {
  return LibraryBuilder(
    const NameGenerator(),
    generatedExtension: '.name.dart',
  );
  // return SharedPartBuilder([const NameGenerator()], 'name');
}

class NameGenerator extends GeneratorForAnnotation<GenerateName> {
  const NameGenerator();

  /// Specify `part of` for the generated code file.
  /// The generate code file should beside the source library file.
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final result = await super.generate(library, buildStep);
    return "part of '${basename(library.element.identifier)}';\n\n$result";
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
      default:
        throw Exception('unsupported element type: ${element.runtimeType}');
    }
  }

  String _generateClassName(ClassElement element) {
    final name = '_\$${element.displayName}\$className';
    final value = element.displayName;
    return "const $name = '$value';";
  }
}
