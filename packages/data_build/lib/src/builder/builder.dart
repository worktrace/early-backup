import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/file_system/file_system.dart' show ResourceProvider;

class Builder {
  Builder({
    required List<String> includedPaths,
    List<String>? excludedPaths,
    ResourceProvider? resourceProvider,
    String? sdkPath,
    this.builders = const [],
  }) : assert(includedPaths.isNotEmpty),
       _contexts = AnalysisContextCollection(
         includedPaths: includedPaths,
         excludedPaths: excludedPaths,
         resourceProvider: resourceProvider,
         sdkPath: sdkPath,
       );

  final AnalysisContextCollection _contexts;
  final Iterable<FileBuilder> builders;

  Future<SomeResolvedUnitResult> resolve(String path) {
    return _contexts.contextFor(path).currentSession.getResolvedUnit(path);
  }

  Future<void> buildFile(String path) async {
    final result = await resolve(path);
    if (result is! ResolvedUnitResult) return;
    for (final builder in builders) {
      final output = builder(path, result.unit);
      if (output != null) {
        File(output.path)
          ..createSync(recursive: true)
          ..writeAsStringSync(output.content);
      }
    }
  }
}

typedef FileBuilder = BuildOutput? Function(String path, CompilationUnit unit);
typedef ContentBuilder = String? Function(String path, CompilationUnit unit);

class BuildOutput {
  const BuildOutput({required this.path, this.content = '\n'});

  final String path;
  final String content;
}

/// How to build based on an annotation and its annotated element.
typedef AnnotationBuilder<T> = String Function(Element2 element, T annotation);
