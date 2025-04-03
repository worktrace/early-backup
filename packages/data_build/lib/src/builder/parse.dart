import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:compat_utils/path.dart';
import 'package:data_build/annotation.dart';

import 'annotation_builder.dart';
import 'builder.dart';

final FileBuilder parseBuilder = annotationBuilder(
  path: (raw) => raw.withSubname('parse'),
  parsers: [parseGenerateParse],
  builders: [buildGenerateParse],
);

GenerateParse? parseGenerateParse(Annotation annotation) {
  return null;
}

String? buildGenerateParse(Element2 element, Object? annotation) {
  return null;
}
