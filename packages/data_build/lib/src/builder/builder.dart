import 'package:analyzer/dart/ast/ast.dart';

typedef FileBuilder = BuildOutput? Function(String path, CompilationUnit unit);
typedef ContentBuilder = String? Function(String path, CompilationUnit unit);

class BuildOutput {
  const BuildOutput({required this.path, this.content = '\n'});

  final String path;
  final String content;
}

/// How to build based on an annotation.
typedef AnnotationBuilder<T> = String Function(T annotation);
