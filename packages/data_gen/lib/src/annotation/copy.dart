import 'package:meta/meta_meta.dart';

import 'abstraction.dart';
import 'name.dart';

part 'copy.name.dart';

/// Generate the `copyWith` method based on current constructor.
///
/// 1. Only parameters with the field of the same name will be included,
/// 2. When there's any required parameter without corresponding field,
/// it will throw exception when building (generating code).
@name
const copy = GenerateCopy();

/// See the [copy] annotation.
@Target({TargetKind.constructor})
@name
class GenerateCopy extends DataAnnotation {
  const GenerateCopy();

  static const String name = _$GenerateCopy$className;
  static const String shortcut = _$copy$topLevelVariableName;
  static const String libraryIdentifier = _$libraryIdentifier;
}
