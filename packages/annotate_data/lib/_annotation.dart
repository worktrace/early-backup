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
  const GenerateEquals({this.includePrivate = true, this.ignores = const []});

  /// Whether to include private fields in the generated code.
  ///
  /// It's recommended to enable because
  /// it will usually generate inside a part file,
  /// which can access the private fields of the source code.
  @name
  final bool includePrivate;

  /// All fields here will be ignored.
  ///
  /// There's no type constraint, and the analyzer will parse its name
  /// to determine which field to ignore.
  /// All unignored fields will be compared in the generated code.
  final Iterable<dynamic> ignores;

  static const String fieldIncludePrivate = _$name$includePrivate;
}
