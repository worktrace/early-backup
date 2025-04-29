import 'dart:io';

import 'package:compat_utils/string.dart';
import 'package:path/path.dart' as path;

extension DirectoryUtils on Directory {
  Directory get normalized => Directory(path.normalize(this.path));
}

extension WrapPath on String {
  String get normalized => path.normalize(this);
  String get relative => path.relative(this);
  String get absolute => path.absolute(this);
  String get basename => path.basename(this);
  String get dirname => path.dirname(this);

  String join(String another) => path.join(this, another);
}

extension ModifyPath on String {
  String withSubname(String subname) {
    final basename = this.basename;
    final result = basename.splitLastOnce('.');
    if (result == null) return dirname.join('$basename.$subname').normalized;
    return dirname.join('${result.$1}.$subname.${result.$2}').normalized;
  }

  String replaceExtension(String extension) {
    final basename = this.basename;
    final result = basename.splitLastOnce('.');
    if (result == null) return dirname.join('$basename.$extension').normalized;
    return dirname.join('${result.$1}.$extension').normalized;
  }
}
