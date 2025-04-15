import 'package:meta/meta_meta.dart';

import 'name.dart';

part 'lerp.name.g.dart';

const lerp = GenerateLerp();

@Target({TargetKind.constructor})
class GenerateLerp {
  const GenerateLerp();
}

/// Generate build-in lerp type map of its name and return [TypeID].
const buildInLerp = GenerateBuildInLerp();

@Target({TargetKind.function})
class GenerateBuildInLerp {
  const GenerateBuildInLerp();
}

/// Elementary identifier of a type in static analysis.
///
/// This class is designed especially for types in `package:flutter`
/// which can avoid unnecessary import of `package:flutter`
/// when running the generators with `package:analyzer`.
/// Once import both `package:analyzer` and `package:flutter`,
/// the program will crash.
@name
class TypeID {
  const TypeID({required this.typeName, this.libraryIdentifier});

  @name
  final String typeName;

  @name
  final String? libraryIdentifier;

  static String className = _$name$TypeID;
  static String fieldTypeName = _$name$typeName;
  static String fieldLibraryIdentifier = _$name$libraryIdentifier;
}
