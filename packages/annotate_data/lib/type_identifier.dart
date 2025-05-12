import 'package:build_name/annotation.dart';

part 'type_identifier.name.g.dart';

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
  static const String nameField = _$name$name;
  static const String libraryIdentifierField = _$name$libraryIdentifier;
}
