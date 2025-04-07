import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/file_system/file_system.dart' show ResourceProvider;
import 'package:compat_utils/iterable.dart';
import 'package:compat_utils/package.dart';
import 'package:compat_utils/path.dart';
import 'package:compat_utils/trace.dart';

class Builder {
  /// All [includedPaths] must be absolute and normalized,
  /// which is required by the encapsulated [AnalysisContextCollection].
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
    trace.trace('analyzing file: $path');
    final result = await resolve(path);
    if (result is! ResolvedUnitResult) return;
    for (final builder in builders) {
      final output = builder(path, result.unit);
      if (output != null) {
        File(output.path)
          ..createSync(recursive: true)
          ..writeAsStringSync(output.content);
        trace.debug('update file: ${output.path}');
      }
    }
  }
}

class PackageBuilder extends Builder with DartPackageFiles {
  /// Construct a builder instance from a Dart package.
  ///
  /// This path will be ensured to be absolute and normalized
  /// inside the constructor. But the specified [root] directory must exist,
  /// or it will throw an exception inside the constructor.
  PackageBuilder(
    this.root, {
    super.excludedPaths,
    super.resourceProvider,
    super.sdkPath,
    super.builders,
  }) : assert(root.existsSync()),
       assert(root.isAbsolute),
       super(includedPaths: DartPackageFiles.dirnames.map(root.path.join).list);

  factory PackageBuilder.resolve({
    String root = '',
    List<String>? excludedPaths,
    ResourceProvider? resourceProvider,
    String? sdkPath,
    Iterable<FileBuilder> builders = const [],
  }) => PackageBuilder(
    root.isEmpty ? Directory.current : Directory(root).absolute.normalized,
    excludedPaths: excludedPaths,
    resourceProvider: resourceProvider,
    sdkPath: sdkPath,
    builders: builders,
  );

  @override
  final Directory root;

  Future<void> build({bool libOnly = true}) async {
    final entries = libOnly ? libDir.allDartFiles : allDartFiles;
    for (final file in entries) await buildFile(file.path);
  }

  Future<void> buildConcurrent({bool libOnly = true}) {
    final entries = libOnly ? libDir.allDartFiles : allDartFiles;
    return Future.wait(entries.map((file) => buildFile(file.path)));
  }
}

typedef FileBuilder = BuildOutput? Function(String path, CompilationUnit unit);
typedef ContentBuilder = String? Function(String path, CompilationUnit unit);

class BuildOutput {
  const BuildOutput({required this.path, this.content = '\n'});

  final String path;
  final String content;
}
