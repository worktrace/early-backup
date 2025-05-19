/// This library will also export [TypeIdentifier],
/// because such annotation will generate such type in a part file.
///
/// @docImport 'type_identifier.dart';
library;

import 'package:meta/meta_meta.dart';

const typeIdentifier = GenerateTypeIdentifier();

/// Generate [TypeIdentifier] for all types inside the annotated [Set].
///
/// This annotation is supposed to annotate on a top level variable of [Set]
/// of [Type]s, that all [Type]s here will have [TypeIdentifier] generated.
/// This annotation is usually used as generating preprocess
/// rather than exact product.
@Target({TargetKind.topLevelVariable})
class GenerateTypeIdentifier {
  const GenerateTypeIdentifier();
}
