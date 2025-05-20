import 'package:analyzer/dart/element/type.dart';
import 'package:annotate_type/_type_identifier.dart';

export 'package:annotate_type/_type_identifier.dart';

extension ParseTypeIdentifier on DartType {
  TypeIdentifier get identifier => TypeIdentifier(
    name: toString(),
    libraryIdentifier: element?.library?.identifier,
  );
}
