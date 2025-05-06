import 'package:meta/meta_meta.dart';

const lerp = GenerateLerp();

/// Generate lerp function according to a constructor.
@Target({TargetKind.constructor})
class GenerateLerp {
  const GenerateLerp();
}

const buildInLerp = GenerateBuildInLerp();

/// Generate lerp function according to build-in constructors (functions).
@Target({TargetKind.topLevelVariable})
class GenerateBuildInLerp {
  const GenerateBuildInLerp();
}
