import 'package:meta/meta_meta.dart';

const copy = GenerateCopy();

@Target({TargetKind.constructor, TargetKind.topLevelVariable})
class GenerateCopy {
  const GenerateCopy();
}
