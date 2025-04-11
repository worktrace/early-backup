import 'name.dart';

part 'copy_deps.name.g.dart';

/// Mark that a type has `copyWith` method.
@name
// ignore: one_member_abstracts interface define.
abstract interface class Copyable {
  /// Generate a new instance from current one with specified fields updated.
  dynamic copyWith();

  static const String name = _$name$Copyable;
}
