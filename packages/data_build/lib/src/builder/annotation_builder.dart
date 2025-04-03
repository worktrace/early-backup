import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:compat_utils/iterable.dart';
import 'package:compat_utils/types.dart';

import 'builder.dart';

/// It is supposed to detect type inside this callback,
/// and return null if not match.
typedef AnnotationBuilder = String? Function(Element2 element, Object? anno);
typedef AnnotationParser<T> = T? Function(Annotation anno);

FileBuilder annotationBuilder({
  required Compiler<String> path,
  Iterable<ContentBuilder> prefixes = const [],
  Iterable<AnnotationParser<dynamic>> parsers = const [],
  Iterable<AnnotationBuilder> builders = const [],
}) => (sourcePath, unit) {
  final outPath = path(sourcePath);
  if (outPath == sourcePath) throw Exception('output to raw file: $outPath');

  final buffer = prefixes.map((b) => b(sourcePath, unit)).whereType<String>();
  final visitor = AnnotationVisitor(
    buffer: buffer,
    parsers: parsers,
    builders: builders,
  );
  unit.visitChildren(visitor);
  return BuildOutput(path: outPath, content: buffer.join('\n\n'));
};

class AnnotationVisitor extends RecursiveAstVisitor<void> {
  const AnnotationVisitor({
    required this.buffer,
    this.parsers = const [],
    this.builders = const [],
  });

  final Iterable<String> buffer;
  final Iterable<AnnotationParser<dynamic>> parsers;
  final Iterable<AnnotationBuilder> builders;

  @override
  void visitAnnotation(Annotation node) {
    super.visitAnnotation(node);
    final annotation = parsers.map((p) => p(node)).firstMaybeNotNull;
    if (annotation == null) return;
  }
}
