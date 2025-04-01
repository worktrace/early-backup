import 'dart:io';

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
