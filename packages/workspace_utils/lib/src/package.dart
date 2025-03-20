import 'dart:io';

import 'package:compat_utils/compat_utils.dart';
import 'package:path/path.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

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

extension DartPackageChildren on DartPackage {
  /// Get child packages iterable inside current workspace.
  Iterable<DartPackage> get children {
    final manifest = this.manifest;
    if (!manifest.containsKey('workspace')) return [];
    if (manifest['workspace'] is! YamlList) return [];
    return (manifest['workspace'] as YamlList)
        .whereType<String>() //
        .map(DartPackage.from);
  }

  /// Get child packages map on their names inside current workspace.
  Map<String, DartPackage> get childPackages {
    final handler = <String, DartPackage>{};
    for (final child in children) handler[child.name] = child;
    return handler;
  }

  /// Get sorted packages by dependencies that all packages will not depends
  /// on any package before them.
  /// The root package of the workspace is also included.
  List<DartPackage> get sortedPackages {
    final packages = {name: this, ...childPackages};
    final nodes = packages.map((key, value) => MapEntry(key, <String>{}));
    final names = nodes.keys;
    packages.forEach((key, value) {
      final p = value;
      final dependencies = {...p.dependencies.keys, ...p.devDependencies.keys};
      for (final name in dependencies) {
        if (names.contains(name)) nodes[name]!.add(name);
      }
    });
    return sortDependencies(nodes).map((name) => packages[name]!).toList();
  }
}

extension DartPackageDependencies on DartPackage {
  Map<String, VersionConstraint> get dependencies {
    return _parseDependencies(_DependenciesMode.dependencies);
  }

  Map<String, VersionConstraint> get devDependencies {
    return _parseDependencies(_DependenciesMode.devDependencies);
  }

  Map<String, VersionConstraint> _parseDependencies(_DependenciesMode mode) {
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
    final dependencies = manifest[_DependenciesMode.dependencies.asPubspecKey];
    return dependencies is YamlMap && dependencies.containsKey('flutter');
  }
}

enum _DependenciesMode {
  dependencies,
  devDependencies;

  String get asPubspecKey => name.snakeCase;
}

extension DartPackageTest on DartPackage {
  bool get hasFlutterTest {
    final manifest = this.manifest;
    for (final key in _DependenciesMode.values.map((k) => k.asPubspecKey)) {
      if (manifest.containsKey(key)) {
        final deps = manifest[key] as YamlMap;
        if (deps.containsKey('flutter_test')) return true;
      }
    }
    return false;
  }

  bool get hasTestFile {
    if (!testDir.existsSync()) return false;
    return testDir
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('_test.dart'))
        .isNotEmpty;
  }

  Future<void> test({
    bool workspace = true,
    ProcessStartMode mode = ProcessStartMode.inheritStdio,
  }) async {
    if (hasTestFile) await testCurrent(mode: mode);
    if (workspace) {
      for (final child in children) {
        await child.test(workspace: false, mode: mode);
      }
    }
  }

  Future<void> testCurrent({
    ProcessStartMode mode = ProcessStartMode.inheritStdio,
  }) async {
    final process = await Process.start(
      hasFlutterTest ? 'flutter' : 'dart',
      ['test'],
      runInShell: true,
      workingDirectory: root.path,
      mode: mode,
    );
    if (await process.exitCode != 0) {
      var message = 'test failed at: ${root.path}';
      if (mode == ProcessStartMode.detached) message += stderr.toString();
      throw Exception(message);
    }
  }
}

extension DartPackageBuild on DartPackage {
  /// Whether the package has `build_runner` and `build.yaml`,
  /// that it requires generated code and can be processed by `build_runner`.
  bool get hasBuild {
    const buildRunner = 'build_runner';
    final hasBuildRunner =
        dependencies.containsKey(buildRunner) ||
        devDependencies.containsKey(buildRunner);

    final hasBuildConfig = root
        .listSync() //
        .any((item) => item is File && basename(item.path) == 'build.yaml');

    return hasBuildRunner && hasBuildConfig;
  }

  Future<void> build({
    bool workspace = true,
    ProcessStartMode mode = ProcessStartMode.inheritStdio,
  }) async {
    if (hasBuild) await buildCurrent(mode: mode);
    if (workspace) {
      for (final child in children) {
        await child.build(workspace: false, mode: mode);
      }
    }
  }

  Future<void> buildCurrent({
    ProcessStartMode mode = ProcessStartMode.inheritStdio,
    bool deleteConflictingOutputs = true,
  }) async {
    final d = deleteConflictingOutputs;
    final process = await Process.start(
      'dart',
      ['run', 'build_runner', 'build', if (d) '--delete-conflicting-outputs'],
      runInShell: true,
      workingDirectory: root.path,
      mode: mode,
    );
    if (await process.exitCode != 0) {
      var message = 'build failed at: ${root.path}';
      if (mode == ProcessStartMode.detached) message += stderr.toString();
      throw Exception(message);
    }
  }
}

extension DartPackageUpdateVersion on DartPackage {
  /// Update Dart SDK and Flutter versions of current workspace.
  void updateEnvironment({
    VersionConstraint? sdk,
    VersionConstraint? flutter,
    bool workspace = true,
  }) {
    updateCurrentEnvironment(sdk: sdk, flutter: flutter);
    if (workspace) {
      for (final child in children) {
        child.updateEnvironment(sdk: sdk, flutter: flutter, workspace: false);
      }
    }
  }

  /// Update Dart SDK and Flutter versions of current package.
  void updateCurrentEnvironment({
    VersionConstraint? sdk,
    VersionConstraint? flutter,
  }) {
    if (sdk == null && flutter == null) return;
    const environment = 'environment';
    final editor = YamlEditor(manifestFile.readAsStringSync());
    if (sdk != null) editor.update([environment, 'sdk'], sdk.toString());
    if (flutter != null && isFlutter) {
      editor.update([environment, 'flutter'], flutter.toString());
    }
    manifestFile.writeAsStringSync(editor.toString());
  }
}

/// Exception about the structure of pubspec.yaml.
class PubspecException implements Exception {
  const PubspecException({required this.message, required this.root});

  final String message;
  final Directory root;

  @override
  String toString() => 'PubspecException at $root: $message';
}
