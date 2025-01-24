import 'package:meta/meta_meta.dart';

import 'annotation.dart';

const mapEncode = MapEncode();
const mapDecode = MapDecode();

@Target({TargetKind.classType})
class MapEncode extends DataAnnotation {
  const MapEncode();
}

@Target({TargetKind.constructor})
class MapDecode extends DataAnnotation {
  const MapDecode();
}
