import 'package:meta/meta_meta.dart';

const copy = GenerateCopy();

@Target({TargetKind.constructor})
class GenerateCopy {
  const GenerateCopy();
}

/// Mark that a type has `copyWith` method.
// ignore: one_member_abstracts interface define.
abstract interface class Copyable {
  /// Generate a new instance from current one with specified fields updated.
  dynamic copyWith();
}
