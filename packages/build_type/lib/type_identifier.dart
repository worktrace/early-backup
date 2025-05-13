import 'package:analyzer/dart/element/type.dart';
import 'package:annotate_type/type_identifier.dart';

export 'package:annotate_type/type_identifier.dart';

extension ParseTypeIdentifier on DartType {
  TypeIdentifier get identifier => TypeIdentifier(
    name: toString(),
    libraryIdentifier: element?.library?.identifier,
  );
}

extension GenerateTypeIdentifierCode on TypeIdentifier {
  String get code =>
      '${TypeIdentifier.className}('
      '${TypeIdentifier.nameField}: $name, '
      '${TypeIdentifier.libraryIdentifierField}: $libraryIdentifier'
      ')';
}
