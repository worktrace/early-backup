import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'composed_generator.dart';

abstract class RecursiveGenerator extends ComposedGenerator {
  const RecursiveGenerator();

  /// Define how to generate a single element in the AST.
  ///
  /// All elements in the AST will be visited, which might cost a lot,
  /// so it's supposed to return `null` when necessary as soon as possible
  /// to tell the recursive visitor to skip redundant steps.
  String? generateElement(Element element);

  /// Visit all elements recursively and generate when necessary.
  @override
  Iterable<String> generateComponents(
    LibraryReader library,
    BuildStep buildStep,
  ) => _generateComponents(library.element);

  /// Recursive encapsulation of generating a single layer of element in AST.
  Iterable<String> _generateComponents(Element element) sync* {
    for (final element in element.children) {
      final result = generateElement(element);
      if (result != null) yield result;
      yield* _generateComponents(element);
    }
  }
}
