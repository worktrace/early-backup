import 'package:build_name/annotation.dart';
import 'package:meta/meta_meta.dart';

part '_register_lerp.name.g.dart';

@name
const registerLerp = GenerateRegisterLerp();

@Target({TargetKind.function})
@libraryIdentifier
class GenerateRegisterLerp {
  const GenerateRegisterLerp();

  static const String shortcut = _$name$registerLerp;
  static const String libraryIdentifier = _$lib$GenerateRegisterLerp;
}
