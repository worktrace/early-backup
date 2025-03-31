import 'dart:io';

import 'package:compat_utils/compat_utils.dart';
import 'package:path/path.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

class DartPackage {
  const DartPackage(this.root);

  DartPackage.from(String path) : root = Directory(path);

  factory DartPackage.resolve({String path = ''}) {
    return DartPackage(Directory(path).absolute.normalized);
  }

  final Directory root;

  Directory get binDir => Directory(join(root.path, 'bin'));
  Directory get libDir => Directory(join(root.path, 'lib'));
  Directory get testDir => Directory(join(root.path, 'test'));
  Directory get exampleDir => Directory(join(root.path, 'example'));
}

extension DartPackageManifest on DartPackage {
  File get manifestFile => File(join(root.path, 'pubspec.yaml'));
  YamlMap get manifest => loadYaml(manifestFile.readAsStringSync()) as YamlMap;

  String get name {
    final name = manifest['name'];
    if (name is String) return name;
    throw PubspecException(message: 'cannot find name', root: root);
  }

  Version get version {
    final version = manifest['version'];
    if (version is String) return Version.parse(version);
    throw PubspecException(message: 'cannot find version', root: root);
  }
}

extension DartPackageDependencies on DartPackage {
  Map<String, VersionConstraint> get dependencies {
    return _parseDependencies(DependenciesKind.dependencies);
  }

  Map<String, VersionConstraint> get devDependencies {
    return _parseDependencies(DependenciesKind.devDependencies);
  }

  Map<String, VersionConstraint> _parseDependencies(DependenciesKind mode) {
    final dependencies = manifest[mode.asPubspecKey];
    if (dependencies is! YamlMap) return {};
    final handler = <String, VersionConstraint>{};
    for (final entry in dependencies.entries) {
      if (entry.key is String && entry.value is String) {
        final version = VersionConstraint.parse(entry.value as String);
        handler[entry.key as String] = version;
      }
    }
    return handler;
  }

  bool get isFlutter {
    final dependencies = manifest[DependenciesKind.dependencies.asPubspecKey];
    return dependencies is YamlMap && dependencies.containsKey('flutter');
  }
}

enum DependenciesKind {
  dependencies,
  devDependencies;

  String get asPubspecKey => name.snakeCase;
}

/// Exception about the structure of pubspec.yaml.
class PubspecException implements Exception {
  const PubspecException({required this.message, required this.root});

  final String message;
  final Directory root;

  @override
  String toString() => 'PubspecException at $root: $message';
}
