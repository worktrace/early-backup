import 'package:meta/meta_meta.dart';

@parse
const parse = GenerateParse();

@Target({TargetKind.constructor, TargetKind.topLevelVariable})
class GenerateParse {
  @parse
  const GenerateParse();
}
