import 'package:meta/meta_meta.dart';

const parse = GenerateParse();

@Target({TargetKind.constructor, TargetKind.topLevelVariable})
class GenerateParse {
  const GenerateParse();

  // Maintained manually, don't forget to update.
  static const name = 'GenerateParse';
  static const shortcut = 'parse';
  static const libIdentifier = 'package:data_build/src/annotation/parse.dart';
}
