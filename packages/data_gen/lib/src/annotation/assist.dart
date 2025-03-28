import 'package:meta/meta_meta.dart';

/// Abstract class as generics for parsing.
abstract class DataAnnotation {
  const DataAnnotation();
}

const parse = GenerateParse();

@Target({TargetKind.constructor})
class GenerateParse {
  const GenerateParse();
}
