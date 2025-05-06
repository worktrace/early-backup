import 'package:build_name/annotation.dart';
import 'package:meta/meta_meta.dart';

part 'build_in_anno.name.g.dart';

@name
const buildInLerp = GenerateBuildInLerp();

@Target({TargetKind.function})
class GenerateBuildInLerp {
  const GenerateBuildInLerp();

  static const String shortcutName = _$name$buildInLerp;
}
