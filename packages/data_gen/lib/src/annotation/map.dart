import 'package:meta/meta_meta.dart';

import 'assist.dart';
import 'name.dart';

part 'map.name.dart';

abstract class MapAnnotation extends DataAnnotation {
  const MapAnnotation();
}

@name
const mapEncode = GenerateMapEncode();

@name
const mapDecode = GenerateMapDecode();

@Target({TargetKind.classType})
@name
class GenerateMapEncode extends MapAnnotation {
  const GenerateMapEncode();

  static const String name = _$GenerateMapEncode$className;
  static const String shortcut = _$mapEncode$topLevelVariableName;
  static const String libraryIdentifier = _$libraryIdentifier;
}

@Target({TargetKind.constructor})
@name
class GenerateMapDecode extends MapAnnotation {
  const GenerateMapDecode();

  static const String name = _$GenerateMapDecode$className;
  static const String shortcut = _$mapDecode$topLevelVariableName;
  static const String libraryIdentifier = _$libraryIdentifier;
}
