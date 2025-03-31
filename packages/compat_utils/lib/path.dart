import 'dart:io';

import 'package:path/path.dart';

extension DirectoryUtils on Directory {
  Directory get normalized => Directory(normalize(path));
}
