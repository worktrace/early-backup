import 'package:build_name/annotation.dart';

part '_type_identifier.name.g.dart';

@name
@libraryIdentifier
class TypeIdentifier {
  const TypeIdentifier({required this.name, this.libraryIdentifier});

  @GenerateName() // Shortcut name conflict.
  final String name;

  @GenerateName() // Shortcut name conflict.
  final String? libraryIdentifier;

  static const String className = _$name$TypeIdentifier;
  static const String classLibraryIdentifier = _$lib$TypeIdentifier;
  static const String fieldName = _$name$name;
  static const String fieldLibraryIdentifier = _$name$libraryIdentifier;
}
