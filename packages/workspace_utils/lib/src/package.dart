import 'dart:io';

import 'package:compat_utils/compat_utils.dart';

class DartPackage {
  const DartPackage(this.root);

  DartPackage.from(String path) : root = Directory(path);

  factory DartPackage.resolve({String path = ''}) {
    return DartPackage(Directory(path).absolute.normalized);
  }

  final Directory root;
}
