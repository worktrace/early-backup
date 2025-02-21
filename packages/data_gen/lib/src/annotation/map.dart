import 'package:meta/meta_meta.dart';

import 'abstraction.dart';
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
class GenerateMapEncode extends MapAnnotation with DataAnnotationShortcut {
  const GenerateMapEncode();

  @override
  String get name => _$GenerateMapEncode$className;

  @override
  String get shortcut => _$mapEncode$topLevelVariableName;
}

@Target({TargetKind.constructor})
@name
class GenerateMapDecode extends MapAnnotation with DataAnnotationShortcut {
  const GenerateMapDecode();

  @override
  String get name => _$GenerateMapDecode$className;

  @override
  String get shortcut => _$mapDecode$topLevelVariableName;
}
