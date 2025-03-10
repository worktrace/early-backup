import 'package:meta/meta_meta.dart';

import 'abstraction.dart';
import 'name.dart';

part 'map.name.dart';

abstract class MapAnnotation extends DataAnnotation {
  const MapAnnotation();
}

@name
const mapEncode = GenerateMapEncode();
const String mapEncodeAnnotationName = _$mapEncode$topLevelVariableName;

@name
const mapDecode = GenerateMapDecode();
const String mapDecodeAnnotationName = _$mapDecode$topLevelVariableName;

@Target({TargetKind.classType})
@name
class GenerateMapEncode extends MapAnnotation {
  const GenerateMapEncode();

  @override
  String get libraryIdentifier => _$libraryIdentifier;

  @override
  String get name => _$GenerateMapEncode$className;
}

@Target({TargetKind.constructor})
@name
class GenerateMapDecode extends MapAnnotation {
  const GenerateMapDecode();

  @override
  String get libraryIdentifier => _$libraryIdentifier;

  @override
  String get name => _$GenerateMapDecode$className;
}
