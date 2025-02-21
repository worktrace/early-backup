/// The name annotation.
library;

import 'package:meta/meta_meta.dart';

import 'abstraction.dart';

part 'name.name.dart';

const name = GenerateName();

/// The annotation to generate name of the annotated element.
@Target({TargetKind.classType})
@name
class GenerateName extends DataAnnotation {
  const GenerateName();

  @override
  String get name => _$generateNameClassName;
}
