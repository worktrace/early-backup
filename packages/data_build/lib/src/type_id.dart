/// Elementary identifier of a type in static analysis.
///
/// This class is designed especially for types in `package:flutter`
/// which can avoid unnecessary import of `package:flutter`
/// when running the generators with `package:analyzer`.
/// Once import both `package:analyzer` and `package:flutter`,
/// the program will crash.
class TypeID {
  const TypeID({required this.name, this.libraryIdentifier});

  final String name;
  final String? libraryIdentifier;
}
