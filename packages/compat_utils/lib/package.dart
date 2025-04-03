import 'dart:io';

import 'package:compat_utils/path.dart';
import 'package:path/path.dart';

mixin DartPackageDirs {
  Directory get root;

  static const bin = 'bin';
  static const lib = 'lib';
  static const test = 'test';
  static const example = 'example';
  static const List<String> names = [bin, lib, test, example];

  Directory get binDir => Directory(join(root.path, 'bin'));
  Directory get libDir => Directory(join(root.path, 'lib'));
  Directory get testDir => Directory(join(root.path, 'test'));
  Directory get exampleDir => Directory(join(root.path, 'example'));

  Iterable<Directory> get dirs => [binDir, libDir, testDir, exampleDir];
}

class DartPackage with DartPackageDirs {
  const DartPackage(this.root);
  DartPackage.from(String path) : root = Directory(path);
  DartPackage.resolve({String path = ''})
    : root = Directory(path).absolute.normalized;

  @override
  final Directory root;
}
