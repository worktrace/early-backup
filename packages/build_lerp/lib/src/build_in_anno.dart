import 'package:meta/meta_meta.dart';
import 'package:nest_gen/utils.dart';

const buildInLerp = GenerateBuildInLerp();

@Target({TargetKind.function})
class GenerateBuildInLerp {
  const GenerateBuildInLerp();

  static const shortcutName = 'buildInLerp';
}

extension TypeIdentifierMatch on Map<String, TypeIdentifier> {
  String? match(String typeName, String? libraryIdentifier) {
    for (final entry in entries) {
      final (name, lib) = entry.value;
      if (name == typeName && lib == libraryIdentifier) return entry.key;
    }
    return null;
  }
}
