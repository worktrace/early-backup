import 'package:meta/meta_meta.dart';

import 'annotation.dart';

abstract class MapAnnotation extends DataAnnotation {
  const MapAnnotation();
}

@Target({TargetKind.classType})
class MapEncode extends MapAnnotation {
  const MapEncode();
}

@Target({TargetKind.constructor})
class MapDecode extends MapAnnotation {
  const MapDecode();
}
