abstract class DataAnnotation {
  const DataAnnotation();

  /// Name of the annotation class, for the generator to parse.
  String get name;
  String get libraryIdentifier;
}
