import 'package:build_name/annotation.dart';
import 'package:meta/meta_meta.dart';

part 'copy.name.g.dart';

const copy = GenerateCopy();

@Target({TargetKind.constructor})
class GenerateCopy {
  const GenerateCopy();
}

/// Mark that a type has `copyWith` method.
@name
// ignore: one_member_abstracts interface define.
abstract interface class Copyable {
  /// Generate a new instance from current one with specified fields updated.
  dynamic copyWith();

  static const String name = _$name$Copyable;
}
