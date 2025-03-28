import 'package:meta/meta_meta.dart';

import 'assist.dart';

/// Generate the `copyWith` method based on current constructor.
///
/// 1. Only parameters with the field of the same name will be included,
/// 2. When there's any required parameter without corresponding field,
/// it will throw exception when building (generating code).
const copy = GenerateCopy();

/// See the [copy] annotation.
@Target({TargetKind.constructor})
class GenerateCopy extends DataAnnotation {
  @parse
  const GenerateCopy();
}
