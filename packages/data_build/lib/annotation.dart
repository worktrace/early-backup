import 'package:data_build/annotation.parse.dart';
import 'package:meta/meta_meta.dart';

export 'annotation.parse.dart';

const copy = GenerateCopy();

@Target({TargetKind.constructor, TargetKind.topLevelVariable})
class GenerateCopy {
  @parse
  const GenerateCopy();
}
