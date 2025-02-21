abstract class DataAnnotation {
  const DataAnnotation();

  /// Name of the annotation class, for the generator to parse.
  String get name;
}

mixin DataAnnotationShortcut on DataAnnotation {
  String get shortcut;
}
