/// The name annotation.
library;

import 'package:meta/meta_meta.dart';

part 'name.name.dart';

@name
const name = GenerateName();

/// The annotation to generate name of the annotated element.
@Target({TargetKind.classType, TargetKind.topLevelVariable})
@name
class GenerateName {
  const GenerateName();

  static const String name = _$GenerateName$className;
  static const String shortcut = _$name$topLevelVariableName;
  static const String libraryIdentifier = _$libraryIdentifier;
}
