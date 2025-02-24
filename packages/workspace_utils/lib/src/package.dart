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

  Iterable<DartPackage> get children {
    final manifest = this.manifest;
    if (!manifest.containsKey('workspace')) return [];
    if (manifest['workspace'] is! YamlList) return [];
    return (manifest['workspace'] as YamlList)
        .whereType<String>()
        .map(DartPackage.from);
  }
}

class PubspecException implements Exception {
  const PubspecException({required this.message, required this.root});

  final String message;
  final Directory root;

  @override
  String toString() => 'PubspecException at $root: $message';
}
