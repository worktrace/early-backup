import 'package:meta/meta_meta.dart';

const lerp = GenerateLerp();

@Target({TargetKind.constructor, TargetKind.topLevelVariable})
class GenerateLerp {
  const GenerateLerp();
}
