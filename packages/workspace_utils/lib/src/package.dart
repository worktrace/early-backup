import 'dart:io';

import 'package:compat_utils/compat_utils.dart';
import 'package:path/path.dart';

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
