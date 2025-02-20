/// The name annotation.
library;

import 'package:meta/meta_meta.dart';

const name = GenerateName();

/// The annotation to generate name of the annotated element.
@Target({TargetKind.classType, TargetKind.parameter})
class GenerateName {
  const GenerateName();
}
