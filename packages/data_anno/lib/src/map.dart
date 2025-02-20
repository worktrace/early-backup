import 'package:meta/meta_meta.dart';

import 'annotation.dart';

abstract class MapAnnotation extends DataAnnotation {
  const MapAnnotation();

  @override
  String get libraryIdentifier => 'package:data_anno/src/map.dart';
}

@Target({TargetKind.classType})
class MapEncode extends MapAnnotation {
  const MapEncode();
}

@Target({TargetKind.constructor})
class MapDecode extends MapAnnotation {
  const MapDecode();
}
