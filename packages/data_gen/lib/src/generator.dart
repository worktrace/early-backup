import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/file_system/file_system.dart' show ResourceProvider;
import 'package:path/path.dart';

abstract class GeneratorBase<T> {
  GeneratorBase({
    required this.entries,
    ResourceProvider? resourceProvider,
    String? sdkPath,
  }) : _collection = AnalysisContextCollection(
          includedPaths:
              entries.map((e) => normalize(e.absolute.path)).toList(),
          resourceProvider: resourceProvider,
          sdkPath: sdkPath,
        );

  final Iterable<FileSystemEntity> entries;
  final AnalysisContextCollection _collection;

  T? generate(File file, CompilationUnit unit);

  Future<SomeResolvedUnitResult> resolve(File file) => _collection
      .contextFor(file.path)
      .currentSession
      .getResolvedUnit(file.path);

  Future<T?> update(File file) async {
    switch (await resolve(file)) {
      case final ResolvedUnitResult result:
        return generate(file, result.unit);
      default:
        return null;
    }
  }
}
