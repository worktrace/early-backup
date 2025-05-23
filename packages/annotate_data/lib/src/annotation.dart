import 'package:build_name/annotation.dart';
import 'package:meta/meta_meta.dart';

part 'annotation.name.g.dart';

const copy = GenerateCopy();
const hash = GenerateHash();
const equals = GenerateEquals();

@Target({TargetKind.constructor})
class GenerateCopy {
  const GenerateCopy();
}

/// Common shared fields between [GenerateHash] and [GenerateEquals].
/// This class is not intended to be annotated on any code.
class GenerateHashBase {
  const GenerateHashBase({this.includePrivate = true});

  /// Whether to include private fields in the generated code.
  ///
  /// It's recommended to enable because
  /// it will usually generate inside a part file,
  /// which can access the private fields of the source code.
  @name
  final bool includePrivate;

  static const String fieldIncludePrivate = _$name$includePrivate;
}

@Target({TargetKind.classType})
class GenerateHash extends GenerateHashBase {
  const GenerateHash({super.includePrivate});
}

@Target({TargetKind.classType})
class GenerateEquals extends GenerateHashBase {
  const GenerateEquals({super.includePrivate});
}
