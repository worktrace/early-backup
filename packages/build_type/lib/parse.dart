import 'package:analyzer/dart/element/type.dart';
import 'package:annotate_type/type_identifier.dart';
import 'package:compat_utils/string.dart';

export 'package:annotate_type/src/type_identifier.dart';

extension ParseTypeIdentifier on DartType {
  TypeIdentifier get identifier => TypeIdentifier(
    name: toString().removeSuffix('?'), // Avoid nullability suffix.
    libraryIdentifier: element?.library?.identifier,
  );
}
