import 'package:build_name/annotation.dart';
import 'package:meta/meta_meta.dart';

part 'annotation.name.g.dart';

const wrap = GenerateWrap();

@Target({TargetKind.constructor, TargetKind.topLevelVariable})
class GenerateWrap {
  const GenerateWrap({this.typeNameOverride, this.constructorNameOverride});

  @name
  final String? typeNameOverride;

  @name
  final String? constructorNameOverride;

  static const String fieldTypeName = _$name$typeNameOverride;
  static const String fieldConstructorName = _$name$constructorNameOverride;
}
