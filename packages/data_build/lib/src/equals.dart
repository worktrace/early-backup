import 'package:meta/meta_meta.dart';

const equals = GenerateEquals();

@Target({TargetKind.classType})
class GenerateEquals {
  const GenerateEquals({this.ignores = const []});

  /// All fields here will be ignored.
  ///
  /// There's no type constraint, and the analyzer will parse its name
  /// to determine which field to ignore.
  /// All unignored fields will be compared in the generated code.
  final Iterable<dynamic> ignores;
}
