import 'package:data_gen/src/annotation/name.dart';
import 'package:meta/meta_meta.dart';

import 'abstraction.dart';

part 'map.name.dart';

abstract class MapAnnotation extends DataAnnotation {
  const MapAnnotation();
}

@Target({TargetKind.classType})
@name
class GenerateMapEncode extends MapAnnotation {
  const GenerateMapEncode();

  @override
  String get name => _$generateMapEncodeClassName;
}

@Target({TargetKind.constructor})
@name
class GenerateMapDecode extends MapAnnotation {
  const GenerateMapDecode();

  @override
  String get name => _$generateMapDecodeClassName;
}
