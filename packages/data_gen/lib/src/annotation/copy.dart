import 'package:meta/meta_meta.dart';

import 'abstraction.dart';
import 'name.dart';

part 'copy.name.dart';

@name
const copy = GenerateCopy();
const String copyAnnotationName = _$copy$topLevelVariableName;

@Target({TargetKind.constructor})
@name
class GenerateCopy extends DataAnnotation {
  const GenerateCopy();

  @override
  String get name => _$GenerateCopy$className;

  @override
  String get libraryIdentifier => _$libraryIdentifier;
}
