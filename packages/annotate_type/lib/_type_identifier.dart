import 'package:build_data/annotation.dart';
import 'package:build_name/annotation.dart';
import 'package:meta/meta.dart';

part '_type_identifier.data.g.dart';
part '_type_identifier.name.g.dart';

@libraryIdentifier
@name
@hash
@equals
@immutable
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

  @override
  bool operator ==(Object other) => _$equals$TypeIdentifier(this, other);

  @override
  int get hashCode => _$hash$TypeIdentifier(this);

  @override
  String toString() => '$name: $libraryIdentifier';
}
