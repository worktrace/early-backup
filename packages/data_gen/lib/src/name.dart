/// The name annotation.
library;

import 'package:meta/meta_meta.dart';

const name = GenerateName();

/// The annotation to generate name of the annotated element.
@Target({TargetKind.classType})
class GenerateName {
  const GenerateName();
}
