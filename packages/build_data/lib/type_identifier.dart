import 'package:analyzer/dart/element/type.dart';
import 'package:annotate_type/type_identifier.dart';

extension ParseTypeIdentifier on DartType {
  TypeIdentifier get identifier => TypeIdentifier(
    name: toString(),
    libraryIdentifier: element?.library?.identifier,
  );
}

extension GenerateTypeIdentifier on TypeIdentifier {
  String get code =>
      '${TypeIdentifier.className}('
      '${TypeIdentifier.nameField}: $name, '
      '${TypeIdentifier.libraryIdentifierField}: $libraryIdentifier'
      ')';
}
