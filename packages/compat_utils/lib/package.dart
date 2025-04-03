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

  Directory get binDir => Directory(join(root.path, 'bin'));
  Directory get libDir => Directory(join(root.path, 'lib'));
  Directory get testDir => Directory(join(root.path, 'test'));
  Directory get exampleDir => Directory(join(root.path, 'example'));

  Iterable<Directory> get dirs => [binDir, libDir, testDir, exampleDir];
}

class DartPackage with DartPackageFiles {
  const DartPackage(this.root);
  DartPackage.from(String path) : root = Directory(path);
  DartPackage.resolve({String path = ''})
    : root = Directory(path).absolute.normalized;

  @override
  final Directory root;
}
