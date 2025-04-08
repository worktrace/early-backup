import 'package:compat_utils/types.dart';
import 'package:source_gen/source_gen.dart';

import 'abstraction.dart';

final copyGenerator = AnnotationGenerator(
  typeChecker: const TypeChecker.fromRuntime(Copy),
  builder: (element, annotation, buildStep) {
    return '// it works';
  },
);
