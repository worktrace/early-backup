import 'package:build_name/annotation.dart';
import 'package:meta/meta_meta.dart';

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
@lib
class TypeID {
  const TypeID({required this.typeName, this.libraryIdentifier});

  @name
  final String typeName;

  @name
  final String? libraryIdentifier;

  static String className = _$name$TypeID;
  static String classLibrary = _$lib$TypeID;
  static String fieldTypeName = _$name$typeName;
  static String fieldLibraryIdentifier = _$name$libraryIdentifier;
}

extension TypeIDMatch on Map<String, TypeID> {
  String? match(String typeName, String? libraryIdentifier) {
    for (final entry in entries) {
      final typeID = entry.value;
      if (typeID.typeName != typeName) continue;
      if (typeID.libraryIdentifier != libraryIdentifier) continue;
      return entry.key;
    }
    return null;
  }
}
