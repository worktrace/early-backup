import 'package:data_gen/src/name.dart';
import 'package:meta/meta_meta.dart';

import 'abstraction.dart';

part 'map.name.dart';

abstract class MapAnnotation extends DataAnnotation {
  const MapAnnotation();

  @override
  String get libraryIdentifier => 'package:data_gen/src/annotation/map.dart';
}

@Target({TargetKind.classType})
@name
class MapEncode extends MapAnnotation {
  const MapEncode();

  @override
  String get name => _$mapEncodeClassName;
}

@Target({TargetKind.constructor})
@name
class MapDecode extends MapAnnotation {
  const MapDecode();

  @override
  String get name => _$mapDecodeClassName;
}
