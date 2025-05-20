import 'package:build_name/annotation.dart';
import 'package:meta/meta_meta.dart';

part '_annotation.name.g.dart';

const copy = GenerateCopy();
const equals = GenerateEquals();

@Target({TargetKind.constructor})
class GenerateCopy {
  const GenerateCopy();
}

@Target({TargetKind.classType})
class GenerateEquals {
  const GenerateEquals({this.includePrivate = true});

  /// Whether to include private fields in the generated code.
  ///
  /// It's recommended to enable because
  /// it will usually generate inside a part file,
  /// which can access the private fields of the source code.
  @name
  final bool includePrivate;

  static const String fieldIncludePrivate = _$name$includePrivate;
}
