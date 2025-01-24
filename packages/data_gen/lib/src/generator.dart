import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:path/path.dart';

abstract class GeneratorBase {
  GeneratorBase({
    required this.entries,
    ResourceProvider? resourceProvider,
    String? sdkPath,
  }) : collection = AnalysisContextCollection(
          includedPaths:
              entries.map((e) => normalize(e.absolute.path)).toList(),
          resourceProvider: resourceProvider,
          sdkPath: sdkPath,
        );

  final Iterable<FileSystemEntity> entries;
  final AnalysisContextCollection collection;
}
