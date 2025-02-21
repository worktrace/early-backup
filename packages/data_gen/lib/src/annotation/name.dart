/// The name annotation.
library;

import 'package:meta/meta_meta.dart';

import 'abstraction.dart';

part 'name.name.dart';

@name
const name = GenerateName();

/// The annotation to generate name of the annotated element.
@Target({TargetKind.classType, TargetKind.topLevelVariable})
@name
class GenerateName extends DataAnnotation with DataAnnotationShortcut {
  const GenerateName();

  @override
  String get libraryIdentifier => _$libraryIdentifier;

  @override
  String get name => _$GenerateName$className;

  @override
  String get shortcut => _$name$topLevelVariableName;
}
