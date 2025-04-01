import 'package:compat_utils/path.dart';

import 'builder.dart';

final FileBuilder parseBuilder = builderOf(
  path: (raw) => raw.withSubname('parse'),
);
