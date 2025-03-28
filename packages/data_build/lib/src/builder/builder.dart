import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element2.dart';

typedef FileBuilder = BuildOutput? Function(String path, CompilationUnit unit);
typedef ContentBuilder = String? Function(String path, CompilationUnit unit);

class BuildOutput {
  const BuildOutput({required this.path, this.content = '\n'});

  final String path;
  final String content;
}

/// How to build based on an annotation and its annotated element.
typedef AnnotationBuilder<T> = String Function(Element2 element, T annotation);
