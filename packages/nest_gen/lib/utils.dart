import 'package:analyzer/dart/element/type.dart';

/// Identifier of a type when analysis.
///
/// This data structure is designed to compatible with both source code
/// and `package:analyzer`. It's not designed as a class to avoid
/// unnecessary code generating of the names.
typedef TypeIdentifier = (String name, String? libraryIdentifier);

extension ConvertTypeIdentifier on DartType {
  TypeIdentifier get identifier {
    return (getDisplayString(), element?.declaration?.library?.identifier);
  }
}
