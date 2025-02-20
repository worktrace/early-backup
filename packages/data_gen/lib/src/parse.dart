import 'package:analyzer/dart/ast/ast.dart';

import 'annotation.dart';

extension ParseDataAnnotation on Annotation {
  DataAnnotation? get parse {
    final libraryIdentifier = element2?.library2?.identifier;
    if (libraryIdentifier == AnnotationLibraries.map) {}
    return null;
  }
}

extension AnnotationLibraries on DataAnnotation {
  static const map = 'package:data_anno/src/map.dart';
}
