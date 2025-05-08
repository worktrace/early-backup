import 'package:meta/meta_meta.dart';

const buildInLerp = GenerateBuildInLerp();

@Target({TargetKind.function})
class GenerateBuildInLerp {
  const GenerateBuildInLerp();

  static const shortcutName = 'buildInLerp';
}

/// Elementary identifier of a type in static analysis.
///
/// This class is designed especially for types in `package:flutter`
/// which can avoid unnecessary import of `package:flutter`
/// when running the generators with `package:analyzer`.
/// Once import both `package:analyzer` and `package:flutter`,
/// the program will crash.
class TypeID {
  const TypeID({required this.typeName, this.libraryIdentifier});

  final String typeName;
  final String? libraryIdentifier;

  static const classLibrary = 'package:build_lerp/src/build_in_anno.dart';
  static const fieldTypeName = 'typeName';
  static const fieldLibraryIdentifier = 'libraryIdentifier';
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
