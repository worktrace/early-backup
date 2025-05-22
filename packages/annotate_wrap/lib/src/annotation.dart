import 'package:build_name/annotation.dart';
import 'package:meta/meta_meta.dart';

part 'annotation.name.g.dart';

const wrap = GenerateWrap();

@Target({TargetKind.constructor, TargetKind.topLevelVariable})
class GenerateWrap {
  const GenerateWrap({
    this.includeDeprecated = false,
    this.typeNameOverride,
    this.constructorNameOverride,
  });

  /// Whether to generate deprecated fields when generating wrap method.
  @name
  final bool includeDeprecated;

  /// You may specify a special name rather than use the default type as the
  /// generated wrap method name.
  /// But attention that this configuration will work for all outputs
  /// of current annotated element, that please consider it
  /// before using such configuration when generating build-in wrap methods.
  @name
  final String? typeNameOverride;

  /// You may specify a special name rather than use the
  /// default constructor name as the generated wrap method name.
  /// But attention that this configuration will work for all outputs
  /// of current annotated element, that please consider it
  /// before using such configuration when generating build-in wrap methods.
  @name
  final String? constructorNameOverride;

  static const String fieldIncludeDeprecated = _$name$includeDeprecated;
  static const String fieldTypeName = _$name$typeNameOverride;
  static const String fieldConstructorName = _$name$constructorNameOverride;
}
