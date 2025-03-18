import 'package:flutter/foundation.dart' show kIsWeb;

export 'src/web/route_io.dart' if (kIsWeb) 'src/web/route.dart';
