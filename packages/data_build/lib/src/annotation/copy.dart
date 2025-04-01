import 'package:meta/meta_meta.dart';

import 'parse.dart';

@parse
const copy = GenerateCopy();

@Target({TargetKind.constructor, TargetKind.topLevelVariable})
class GenerateCopy {
  @parse
  const GenerateCopy();
}
