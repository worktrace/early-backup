import 'dart:io';

import 'package:compat_utils/path.dart';
import 'package:path/path.dart';

mixin DartPackageFiles {
  Directory get root;

  static const binDirname = 'bin';
  static const libDirname = 'lib';
  static const testDirname = 'test';
  static const exampleDirname = 'example';
  static const List<String> dirnames = [
    binDirname,
    libDirname,
    testDirname,
    exampleDirname,
  ];

  Directory get binDir => Directory(join(root.path, binDirname));
  Directory get libDir => Directory(join(root.path, libDirname));
  Directory get testDir => Directory(join(root.path, testDirname));
  Directory get exampleDir => Directory(join(root.path, exampleDirname));

  Iterable<Directory> get dirs => [binDir, libDir, testDir, exampleDir];

  Iterable<File> get allDartFiles => dirs
      .map((dir) => dir.allDartFiles) //
      .expand((file) => file);

  Iterable<File> get allDartTestFiles => dirs
      .map((dir) => dir.allDartTestFiles) //
      .expand((file) => file);
}

extension DartFile on File {
  bool get isDart => path.endsWith('.dart');
  bool get isDartTest => path.endsWith('_test.dart');
}

extension DartFiles on Directory {
  // ignore: unnecessary_this readabilities.
  Iterable<File> get allDartFiles => this
      .listSync(recursive: true) //
      .whereType<File>()
      .where((file) => file.isDart);

  // ignore: unnecessary_this readabilities.
  Iterable<File> get allDartTestFiles => this
      .listSync(recursive: true) //
      .whereType<File>()
      .where((file) => file.isDartTest);
}

class DartPackage with DartPackageFiles {
  const DartPackage(this.root);
  DartPackage.from(String path) : root = Directory(path);
  DartPackage.resolve({String path = ''})
    : root = Directory(path).absolute.normalized;

  @override
  final Directory root;
}
