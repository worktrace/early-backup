abstract class AnnotationToParse {
  const AnnotationToParse();

  /// Name of the annotation class, for the generator to parse.
  String get name;

  /// Library identifier where the source code of the class locates,
  /// for the generator to parse.
  String get libraryIdentifier;
}

abstract class DataAnnotation extends AnnotationToParse {
  const DataAnnotation();
}
