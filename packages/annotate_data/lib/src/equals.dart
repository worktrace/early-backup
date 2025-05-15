import 'package:build_name/annotation.dart';
import 'package:meta/meta_meta.dart';

part 'equals.name.g.dart';

const equals = GenerateEquals();

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
