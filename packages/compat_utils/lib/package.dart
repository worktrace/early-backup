import 'dart:io';

import 'package:compat_utils/path.dart';
import 'package:path/path.dart';

class Package {
  const Package(this.root);
  Package.from(String path) : root = Directory(path);
  Package.resolve({String path = ''})
    : root = Directory(path).absolute.normalized;

  final Directory root;
}

mixin DartPackageDirs on Package {
  Directory get binDir => Directory(join(root.path, 'bin'));
  Directory get libDir => Directory(join(root.path, 'lib'));
  Directory get testDir => Directory(join(root.path, 'test'));
  Directory get exampleDir => Directory(join(root.path, 'example'));
}

class DartPackage extends Package with DartPackageDirs {
  const DartPackage(super.root);
  DartPackage.from(super.path) : super.from();
  DartPackage.resolve({super.path}) : super.resolve();
}
